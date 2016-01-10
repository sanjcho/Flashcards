class CardsController < ApplicationController
  

  def show
    @cards = Card.all
  end

  def new
  	@card = Card.new
  end

  def create
  	@card = Card.create(card_params)
  	@card.save
  	redirect_to cards_path
  end

  def edit
  end

  def update
  	@card = Card.update(card_params)
  	@card.save
  	redirect_to cards_path
  end

  def destroy

  end

  def card_params
  	params.require(:card).permit(:original_text, :translated_text)
  end

end
