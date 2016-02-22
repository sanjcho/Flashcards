class Home::SessionsController < Home::ApplicationController

  def new

  end

  def create
    if login(params[:session][:email], params[:session][:password])
      flash[:success] = t("login_successful")
      redirect_to user_path
    else
      flash[:danger] = t("login_unsuccessful")
      redirect_to new_session_path
    end
  end

  def destroy
    logout
    flash[:success] = t("logout_successful")
    redirect_to home_path
  end

end
