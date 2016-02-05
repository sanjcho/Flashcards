class DecksController < ApplicationController

  before_action :set_user
  before_action :set_deck, only: [:edit, :update]
  def index
    @decks = @user.decks.order("id DESC")
  end

  def new
    @deck = @user.decks.new
  end

  def create
    @deck = @user.decks.new(deck_params)
    if @deck.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def edit

  end

  def update
    if @deck.update(deck_params)
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    @deck = current_user.decks.find(params[:id])
    @deck.destroy
    redirect_to decks_path
  end

  def make_active
    Deck.find(params[:id]).activate!
    redirect_to decks_path    
  end

  private
    def deck_params
      params.require(:deck).permit(:name, :id, :active)
    end

  def set_deck
    @deck = Deck.find(params[:id])
  end

end
