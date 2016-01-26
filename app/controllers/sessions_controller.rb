class SessionsController < ApplicationController
  
  skip_before_action :require_login, only: [:new, :create]

  def new

  end

  def create
    if login(params[:session][:email], params[:session][:password])
      flash[:success] = t("login_successful")
      puts current_user.id
      redirect_to(home_path)
    else
      flash[:danger] = t("login_unsuccessful")
      redirect_to login_path
    end
  end

  def destroy
    logout
    flash[:success] = t("logout_successful")
    redirect_to home_path
  end

end
