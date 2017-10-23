class SessionsController < ApplicationController
  def new
  end

  def create
    # Find the current user using the email provided
    user = User.find_by_email(params[:email])
    # Authenticate is a method provided by has_secure_password, checks against a user's bcrypt password
    if user && user.authenticate(params[:password])
      # Sets user authentication token so that it can be used in future requests. If remember me is set then maintain that authentication token in a cookie
      if params[:remember_me]
        cookies.permanent[:authentication_token] = user.authentication_token
      # Otherwise only remember the cookie for that session
      else
        cookies[:authentication_token] = user.authentication_token
      end
      redirect_to root_url, notice: "Successfully Logged In"
    else
      # Pops up a message on the current window
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    # Delete cookie of authentication token so the user is logged out
    cookies.delete(:authentication_token)
    redirect_to root_url, notice: "Successfully Logged Out"
  end
end
