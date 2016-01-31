class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    if current_user
      @card = current_user.cards.expired.random.first
    end
  end
end
