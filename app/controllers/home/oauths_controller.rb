class Home::OauthsController < Home::ApplicationController
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if current_user
      if @user = add_provider_to_user(provider)
        flash[:success] = t("connection_success")
        redirect_to user_path
      else
        flash[:danger] = user.errors.full_messages
        redirect_to user_path
      end
    elsif @user = login_from(provider)
      flash[:success] = t("You_are_logined_with") + provider.titleize
      redirect_to home_path
    else
      begin
        @user = create_from(provider)
        reset_session # protect from session fixation attack
        auto_login(@user)
        flash[:success] = t("You_are_Signedup_with") + provider.titleize
        redirect_to home_path 
      rescue
        flash[:danger] = provider.to_s.titleize + t("Vk_login_failed")
        redirect_to home_path
      end
    end
  end

  private
  
  def auth_params
     params.permit(:code, :provider)
  end

end