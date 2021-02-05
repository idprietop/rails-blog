class UsersController < ApplicationController
  before_action :validate_session
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    @user.followers << current_user
    redirect_to @user
  end

  def unfollow
    @user = User.find(params[:id])
    @user.received_follows.find_by(follower_id: current_user.id).destroy
    redirect_to @user
  end

  private

  def validate_session
    unless logged_in?
      redirect_to login_path
    end
  end
end
