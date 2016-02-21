class CardsController < ApplicationController
  after_action :flash_clear, only: :compare
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
    result = CardComparator.call(card: card, compared_text: params[:compared_text])
    if result.success?   # absolutely right
      flash[:success] = t("success")
    elsif result.type_error?   # right, but some type errors
      flash[:warning] = t("success_with_type_error") + params[:compared_text] + t("what_is_need_to_be_typed") + card.original_text
    elsif result.wrong?    # error
      flash[:danger] = t("wrong")   
    end
    @flash = flash
    respond_to do |format|
      format.js {}
      format.html {}
      #format.json { render json: {flash: flash}.to_json }
    end
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

  def flash_clear
    flash.clear
  end

end
