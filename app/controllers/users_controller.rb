class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    # Use the form submission to create new user object using User.new,
    # Try and fail to save that user,
    # then render the signup page for possible resubmission.
    def create
        @user = User.new(params[:user]) # Not final!
        if @user.save
            # successful save
        else
            render 'new'
        end
    end
end
