class Api::V1::TokensController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      user.update(token: SecureRandom.uuid)
      render status: 201, json: { token: user.token }
    else
      render status: 401, json: { msg: 'Invalid email or password' }
    end
  end
end
