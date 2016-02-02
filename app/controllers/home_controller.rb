class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    if current_user
      if current_user.active_deck_id?
        @card = Deck.find(current_user.active_deck_id).cards.expired.random.first 
        @deck = @card.deck if @card != nil
      else
        @card = current_user.cards.expired.random.first
      end
    end
  end
end
