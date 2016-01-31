class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    if current_user
      @user = current_user
      @card = @user.cards.expired.random.first
    end
  end
end
