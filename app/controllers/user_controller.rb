class UserController < ApplicationController
before_filter :authenticate_user!

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  end

  def leaderboard
  	@users = User.all
  end
end
