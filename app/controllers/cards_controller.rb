class CardsController < ApplicationController

  helper_method :deck, :card
  def index

    @cards = deck.cards
  end

  def new

    @card = deck.cards.new
  end

  def create

    @card = deck.cards.new(card_params)
    @card.user_id = current_user.id
    if @card.save
      redirect_to deck_cards_path
    else
      render 'new'
    end
  end

  def edit
    card
  end

  def update
    card
    if @card.update(card_params)
      redirect_to deck_cards_path
    else
      render 'edit'
    end
  end

  def destroy
    card.destroy
    redirect_to deck_cards_path
  end

  def compare
    #compared_text = params[:compared_text]
    if CardComparator.call(card: card, compared_text: params[:compared_text])
      flash[:success] = t("success")
    else
      flash[:danger] = t("wrong")   # answer is not correct
    end
    redirect_to home_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :id, :compared_text, :exemplum, :deck_id)
  end

  def deck
    @deck ||= current_user.decks.find(params[:deck_id])
  end

  def card
    @card ||= current_user.cards.find(params[:id])
  end

end
