class Api::V1::UsersController < ApplicationController
  wrap_parameters :user, include: User.attribute_names + [:password]
  
  def create
    user = User.new(user_params)

    if user.save
      render status: 201, json: user
    else
      render status: 422, json: user.errors
    end
  end

  def emails
    if params[:email] && User.find_by(email: params[:email])
      render status: 200, nothing: true
    else
      render status: 404, nothing: true
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
