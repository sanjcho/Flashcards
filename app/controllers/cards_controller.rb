class CardsController < ApplicationController
  
  before_action :set_user

  def index
    @deck = Deck.find(params[:deck_id])
    @cards = @deck.cards.all
  end

  def new
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.new
  end

  def create
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.new(card_params)
    @card.user_id = current_user.id
    if @card.save
      redirect_to deck_cards_path
    else
      render 'new'
    end
  end

  def edit
    @deck = Deck.find(params[:deck_id])
    @card = Card.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:deck_id])
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to deck_cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to deck_cards_path
  end

  def compare
    card = Card.find(params[:id])
    if card.original_text_equal_to?(params[:compared_text])
      card.update_review_date!
      flash[:success] = t("success")
    else
      flash[:danger] = t("wrong")
    end
    redirect_to user_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :id, :compared_text, :exemplum, :deck_id)
  end

end
