class UserSessionsController < ApplicationController
  def new

  end

  def create
    if login(params[:user_session][:email], params[:user_session][:password])
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

#  private
#    def user_sessions_params
#    	params.require(:user_session).permit(:email, :password)
#    end
end
