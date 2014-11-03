class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

end

# restrict_access
# This is a method that will allow us to redirect and inform the user they must log 
# in anytime they attempt to access a controller action we don't want them to.

# current user
# As you can see, this helper method will return the logged in user by checking the 
# session[:user_id] value we set upon log in. Now we can call current_user from both 
# our controllers and views to check our log in status. Very useful!
