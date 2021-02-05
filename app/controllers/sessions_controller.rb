class SessionsController < ApplicationController
  before_action :validate_session, only: %i[new welcome]
  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to articles_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def validate_session
    redirect_to articles_path if logged_in?
  end
end
