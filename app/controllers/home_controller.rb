class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    @card = current_user.card_choose if current_user #if there are user loggined in, check cards for training
    @deck = @card.deck if @card  # if there are some card for training, select deck for link generating
  end
end
