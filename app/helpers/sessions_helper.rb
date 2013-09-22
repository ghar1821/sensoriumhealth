module SessionsHelper

    def sign_in(user)
        # Create a new token (using method in user model)
        remember_token = User.new_remember_token
        # place unencrypted token in browser cookies
        cookies.permanent[:remember_token] = remember_token
        # save the encrypted token to the database
        # update_attribute update a single attribute while bypassing validations.
        user.update_attribute(:remember_token, User.encrypt(remember_token))
        # set the current user equal to user.
        self.current_user = user
    end

    def current_user=(user)
        @current_user = user
    end

    # Ensure user did not get signed off when viewing other pages.
    def current_user
        remember_token = User.encrypt(cookies[:remember_token])
        # set @current_user instance to the user corresponding to the remember token 
        # if @current_user is undefined.
        @current_user ||= User.find_by(remember_token: remember_token)
    end

    # signed_in? helper method.
    def signed_in?
        # A user is signed in if there is a current user in the session, i.e. if current_user is non-nil
        !current_user.nil?
    end
end
