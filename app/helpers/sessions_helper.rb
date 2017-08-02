module SessionsHelper

  # Logs in the given user
  # Places temp cookie in user's browser containing hashed user id
  def log_in(user)
    session[:user_id] = user.id 
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns current user if any
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if user is logged in
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
