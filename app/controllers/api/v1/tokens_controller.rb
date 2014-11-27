class Api::V1::TokensController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      user.update(authentication_token: SecureRandom.uuid)
      render status: 201, json: { token: user.authentication_token }
    else
      render status: 401, json: { msg: 'Invalid email or password' }
    end
  end

  def destroy
    @user = current_user
    if @user.update(authentication_token: nil)
      render status: 200, json: { msg: 'You have successfully signed out' }
    else
      render status: 422, json: { msg: 'There was an error in signing out' }
    end
  end
end
