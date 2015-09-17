class SessionsController < ApplicationController
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by_credentials(email, password)

    if @user
      log_in_user!(@user)
      redirect_to user_url(current_user)
    else
      flash[:error] = "Credentials does not match"
      redirect_to new_session_url
    end
  end

  def new
    if logged_in?
      redirect_to user_url(current_user)
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
