class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
  	if !signed_in?
  		flash[:error] = "You are not signed in."
      redirect_to sign_in_path
    end
  end

  def signed_in?
  	!!current_user
  end
end
