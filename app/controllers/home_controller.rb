class HomeController < ApplicationController
  skip_before_action :require_login
  def index

#      if current_user.cards.expired.exists?
#        if current_user.active_deck_id?
#          @card = current_user.decks.current.cards.expired.random.first 
#        else
#          @card = current_user.cards.expired.random.first
#        end
#        @deck = @card.deck
#      end

    @card = current_user.card_choose
    @deck = @card.deck if @card
  end
end
