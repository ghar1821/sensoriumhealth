class UserController < ApplicationController
before_filter :new_authenticate

	# Showing user profile
	def show
		@user = User.find(params[:id])
	end

	# Showing leaderboard
	def leaderboard
		@users = User.all
	end

	# Show each user's relaxation session
	def show_relaxation_session
		@user = current_user
		@relaxation_sessions = RelaxationSession.where(:username => @user.username)
	end

	# Allowing admin to view user profile as well. New authentication method.
	def new_authenticate
		if !current_admin and !current_user
			authenticate_user
		end
	end
 
end
