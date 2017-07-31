module SessionsHelper

  # Logs in the given user
  # Places temp cookie in user's browser containing hashed user id
  def log_in(user)
    session[:user_id] = user.id 
  end

  # Returns current user if any
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
