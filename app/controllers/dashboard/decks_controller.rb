class Dashboard::DecksController < Dashboard::ApplicationController

  helper_method :deck
  def index
    @decks = current_user.decks.order("id DESC")
  end

  def new
    @deck = current_user.decks.new
  end

  def create
    @deck = current_user.decks.new(deck_params)
    if @deck.save
      redirect_to decks_path
    else
      render "new"
    end
  end

  def edit
    deck
  end

  def update
    if deck.update(deck_params)
      redirect_to decks_path
    else
      render "edit"
    end
  end

  def destroy
    deck.destroy
    redirect_to decks_path
  end

  def make_active
    deck.activate!
    redirect_to decks_path    
  end

  private
    def deck_params
      params.require(:deck).permit(:name, :id, :active)
    end

    def deck
      @deck ||= current_user.decks.find(params[:id])
    end

end
