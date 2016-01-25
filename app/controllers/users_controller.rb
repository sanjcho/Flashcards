class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :set_user, only: [:new, :create]

  def show
    @user = current_user
    @card = @user.cards.expired.random.first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!
    if @user.save
        login(@user.email.downcase, params[:user][:password])
      	redirect_to home_path
        flash[:success] = t('user_created')
    else
      render 'new'
    end
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

  def destroy

  end
  private

    def user_params
      params.require(:user).permit(:id, :email, :password, :password_confirmation)
    end

end
