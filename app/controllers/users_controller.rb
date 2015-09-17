class UsersController < ApplicationController
  before_action :ensure_login, only: [:show]

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      flash[:notice] = "Sucessfully signed up!"
      redirect_to user_url(current_user)
    else
      flash[:error] = "Failed to sign up."
      redirect_to new_user_url
    end
  end

  def new
    if logged_in?
      redirect_to user_url(current_user)
    else
      render :new
    end
  end

  def show
    user = User.find(params[:id])
    if logged_in? && current_user == user
      render :show
    else
      flash[:error] = "You do not have access to this page."
      redirect_to user_url(current_user)
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
