class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  # Defines the current user and it's cached so that it's only requested once
  def current_user
    @current_user ||= User.find_by_authentication_token!(cookies[:authentication_token]) if cookies[:authentication_token]
  end
  # Helper method allows this method to be used in views
  helper_method :current_user

  # Makes it so that a user must be signed in before perfoming an action if this is in a before action for a controller
  def authenticate_user
    redirect_to sign_in_url, alert: "You must be signed in to view this page" if current_user.nil?
  end
end
