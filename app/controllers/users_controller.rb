class UsersController < ApplicationController
  before_action :validate_session
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @followers = @user.followers
    @followings = @user.followings
  end

  def follow
    @user = User.find(params[:id])
    @user.followers << current_user
    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
    if @user.nil?
      redirect_to articles_path
    else
      @user.received_follows.find_by(follower_id: current_user.id).destroy
      redirect_to @user
    end
  end

  private

  def validate_session
    redirect_to login_path unless logged_in?
  end
end
