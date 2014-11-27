class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  skip_before_action :verify_authenticity_token
  
  def current_user
    @user ||= User.find_by(authentication_token: params[:token]) if params[:token]
  end

  helper_method :current_user

  def authenticate_user!
    return render status: 401, json: { msg: 'You must be signed in' } unless current_user
  end

  def authenticate_company!
    return render status: 400, json: { msg: 'You need to create a company first' } unless @user.company
  end

  def user_not_authorized
    render status: 403, json: { msg: 'You are not authorized for that resource' }
  end
end
