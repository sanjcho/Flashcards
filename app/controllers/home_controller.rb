class HomeController < ApplicationController
  skip_before_action :require_login
  def index
    if current_user
      if current_user.active_deck_id?
        @card = Deck.find(current_user.active_deck_id).cards.expired.random.first 
      else
        @card = current_user.cards.expired.random.first
      end
      @deck = @card.deck
    end
  end
end
