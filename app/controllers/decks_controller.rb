class DecksController < ApplicationController

  before_action :set_user

  def index
    @deck = @user.Deck.all
  end

  def new
    @deck = @user.Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    if @deck.save
      redirect to decks_path
    else
      render "new"
    end
  end

  def edit
    @deck = Deck.find(params[:id])

  end

  def update
    @deck = Deck.find(params[:id])
    if @deck.update(deck_params)
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    @deck.find(params[:id])
    @deck.destroy
    redirect_to decks_path
  end

  private
    def deck_params
      params.require(:deck).permit(:name, :id)
    end

end
