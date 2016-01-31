class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    
    if params[:user][:password]
      @user.update(user_params)
      flash[:success] = t('user_update_success')
      redirect_to home_path
    else
      update_columns(email: params[:user][:email])
    end
  end

  private

    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation)
    end

end
