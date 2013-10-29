class UserController < ApplicationController
before_filter :new_authenticate

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def leaderboard
  	@users = User.all
  end

  def show_relaxation_session
  	@user = current_user
  	@relaxation_sessions = RelaxationSession.where(:username => @user.username)
  end

  def new_authenticate
	  if !current_admin and !current_user
	    authenticate_user
	  end

end
 
end
