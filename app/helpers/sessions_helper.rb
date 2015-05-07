module SessionsHelper

  # Set token for user and put it in cookies
  def sign_in(user)
    token = User.new_token
    cookies.permanent[:remember_token] = token
    user.update_attribute(:remember_token, User.digest(token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  # Set current user by finding user with a token equal to cookie token 
  def current_user
    token = User.digest(cookies[:remember_token]) if cookies[:remember_token] 
    @current_user ||= User.find_by(remember_token: token)
  end

  # Assign user a new token and delete the one from cookies
  def sign_out
    current_user.update_attribute(:remember_token,
                                   User.digest(User.new_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in?
    !!current_user
  end
end
