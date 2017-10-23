class PasswordResetsController < ApplicationController
  def new
  end

  def create
    # Searches for a user with the email entered in the password reset form
    user = User.find_by_email(params[:email])
    # Email will be sent regardless if a user is found in the database so it becomes much more secure
    user.send_password_reset if user
    redirect_to root_url, notice: "Password Reset Sent"
  end
  
  def edit
    # Searches for a user with the token generated as the id in the url
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    # Searches for a user with the token generated as the id in the url
    @user = User.find_by_password_reset_token!(params[:id])
    # If the link has been out for more than 10 minutes then do not update the password in the database
    if @user.password_reset_sent_at < 10.minutes.ago
      redirect_to new_password_reset_path, alert: "Password reset link has expired"
    # If the password was successfully changed then redirect to the home page
    elsif @user.update_attributes(password_reset_params)
      redirect_to root_url, notice: "Password successfully reset"
    # Other errors just render the edit page
    else
      render :edit
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
