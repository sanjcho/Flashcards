class CardsController < ApplicationController
  
  def index
    @cards = Card.all
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
    if params[:compared_text].strip == card.original_text.strip
      card.review_actualize
      card.save
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
