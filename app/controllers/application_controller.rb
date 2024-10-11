class ApplicationController < ActionController::API
  def authenticate_user!
    api_key = ApiKey.find_by(token: request.session[:token])
    @current_user = api_key&.bearer
    head :unauthorized unless @current_user if @current_user.nil?
  end
    
  private

  def current_user
    # Logic to find the current user, e.g., from session or token
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
