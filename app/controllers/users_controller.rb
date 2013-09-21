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

        # The below statement translate to:
        # @user = User.new(firstname: "bla", lastname: "bla",
        # email: "lol@lol.com, the remaining attributes).
        # @user = User.new(params[:user])
        # Not secure! Need to use strong parameters
        # Need to ask params hash to have a :user attribute,
        # and permitting all confirmation attributes, i.e. if those
        # attributes are not filled, error will be raised.
        @user = User.new(user_params)
        if @user.save
            # successful save
            # content for the flash message
            flash[:success] = "Welcome to sensoriumhealth!"
            redirect_to @user
        else
            render 'new'
        end
    end

    private

        def user_params
            params.require(:user).permit(:firstname, :lastname,
                                         :email, :dob, :gender,
                                         :username, :password,
                                         :password_confirmation,
                                         :terms)
        end

end
