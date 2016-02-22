class Dashboard::UsersController < ApplicationController

  before_action :set_user

  def show
    
  end

  def edit

  end

  def update
    if params[:user][:password]
      @user.update(user_params)
      I18n.locale = @user.locale if @user.previous_changes.include?("locale")   #if locale was changed
      flash[:success] = t('user_update_success')
      redirect_to home_path
    else
      update_columns(email: params[:user][:email])
    end
  end

  private

    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation, :locale)
    end

    def set_user
      @user = current_user
    end
end
