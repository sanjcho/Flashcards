class CardsController < ApplicationController
  
  before_action :set_user

  def index
    @cards = @user.cards.all
  end
  
  def show
    
  end

  def new
    @card = @user.cards.new
  end

  def create
    @card = @user.cards.new(card_params)
    if @card.save
      redirect_to user_cards_path
    else
      render 'new'
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])
    if @card.update(card_params)
      redirect_to user_cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to user_cards_path
  end

  def compare
    card = Card.find(params[:id])
    if card.original_text_equal_to?(params[:compared_text])
      card.update_review_date!
      flash[:success] = t("success")
    else
      flash[:danger] = t("wrong")
    end
    redirect_to home_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :id, :compared_text)
  end

  def set_user
    @user=current_user
  end

end
