class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    
    if user.save
      render status: 201, json: user
    else
      render status: 422, json: user.errors
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
