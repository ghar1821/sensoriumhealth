class SessionsController < ApplicationController

    def new
    end

    def create
        # pulls the user out of the db using the submitted username
        # username are all stored in downcase.
        user = User.find_by(username: params[:session][:username].downcase)
        # if username exists and the given password matches
        if user && user.authenticate(params[:session][:password])
            # Sign in and redirect to user's profile page
            sign_in user
            redirect_to user
        else
            # Create error message and re-render the sigin
            # Need flash.now instead of just flash so the message do not propagate to other pages.
            flash.now[:error] = 'Invalid username/password combination'
            render 'new'
        end
    end

    def destroy
        sign_out
        redirect_to root_url
    end

end
