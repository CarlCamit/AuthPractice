class User < ApplicationRecord
    has_secure_password
    
    # Ensures an authentication token is generated for each User instance made
    before_create { generate_token(:authentication_token) }

    # Allows the method to work with multiple columns for other processes
    def generate_token(column)
        begin
            # ActiveSupport generates a random string
            self[column] = SecureRandom.urlsafe_base64
        # Token is unique by ensuring no other user exists with that same token
        end while User.exists?(column => self[column])
    end

    def send_password_reset
        # Generates an authentication reset token
        generate_token(:password_reset_token)
        # Sets the current time to be checked against for expiration of reset link later on
        self.password_reset_sent_at = Time.zone.now
        # Saves the User model with a password reset token and time
        save!
        # Send an email to User
        UserMailer.password_reset(self).deliver
    end
end
