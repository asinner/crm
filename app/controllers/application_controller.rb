class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def authenticate_user!
    @user = User.find_by(token: params[:token])
    return render status: 401, json: { msg: 'You are not authorized for that' } unless @user
  end
end
