class CardsController < ApplicationController
  
  def index
    @card = Card.all.expired.random.first
  end
  
  def show
    
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to cards_path
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
      redirect_to cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    render index
  end

  def compare
    card = Card.find(params[:id])
    if card.original_text_equal_to?(params[:compared_text])
      card.update_review_date!
      flash[:success] = t("success")
    else
      flash[:danger] = t("wrong")
    end
    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :id, :compared_text)
  end

end
