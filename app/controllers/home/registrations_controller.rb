class Home::RegistrationsController < Home::ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        login(@user.email.downcase, params[:user][:password])
      	redirect_to home_path
        flash[:success] = t('user_created')
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation, :locale)
    end
end
