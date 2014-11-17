class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  protect_from_forgery with: :exception
  
  def current_user
    @user ||= User.find_by(token: params[:token]) if params[:token]
  end
    
  helper_method :current_user
  
  def authenticate_user!
    return render status: 401, json: { msg: 'You are not authorized for that' } unless current_user
  end
  
  def authenticate_company!
    return render status: 400, json: { msg: 'You need to create a company first' } unless @user.company
  end
  
  def user_not_authorized
    return render status: 403, json: { msg: 'You are not authorized for that resources' }
  end
end
