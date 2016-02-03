class DecksController < ApplicationController

  before_action :set_user

  def index
    @decks = @user.decks
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
    @deck = Deck.find(params[:id])
    @deck.destroy
    redirect_to decks_path
  end

  def make_active
    Deck.find(params[:id]).activate_it!
    redirect_to decks_path    
  end

  private
    def deck_params
      params.require(:deck).permit(:name, :id, :active)
    end

end
