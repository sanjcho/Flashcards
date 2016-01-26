class UsersController < ApplicationController

  def show
    @user = current_user
    @card = @user.cards.expired.random.first
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = t('user_update_success')
      redirect_to home_path
    else
      render "edit"
    end
  end

  private

    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation)
    end

end
