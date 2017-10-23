class UsersController < ApplicationController
    # Creates a new User instance and displays the sign up form
    def new
        @user = User.new
    end

    # Create action that saves the User instance to the database
    def create
        @user = User.new(user_params)
        # If the User instance was successfully saved then redirect to home page and display notice
        if @user.save
            # Set authentication token cookie so that the User is automatically signed in after signing up
            cookies[:authentication_token] = @user.:authentication_token
            redirect_to root_url, notice: "Thank you for signing up."
        # If the User instance was not saved in the database then redisplay the sign up form
        else
            render :new
        end
    end

    private

    # Paramaters that are allowed to pass through
    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :authentication_token, :password_reset_token)
    end
end
