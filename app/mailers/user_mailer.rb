class UserMailer < ApplicationMailer

  # Takes User as argument
  def password_reset(user)
    # Assigned to an instance variable so it can be accessed from the template
    @user = user
    mail to: user.email, subject: "Password Reset"
  end
end
