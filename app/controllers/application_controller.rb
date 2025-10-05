class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout(user)
    Current.user = nil
    reset_session
  end

  def authenticate_user!
    redirect_to login_path, alert: "You must be logged in to continue." unless user_signed_in?
  end

  def current_user
    Current.user || authenticate_user_from_session
  end
  helper_method :current_user # Make this method available in views

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
    # !! current_user # This is a double negation that converts the object to a boolean
  end
  helper_method :user_signed_in? # Make this method available in views
end
