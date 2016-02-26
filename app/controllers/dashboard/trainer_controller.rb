class Dashboard::TrainerController < Dashboard::ApplicationController
  
  def index
    @card = current_user.card_choose if current_user #if there are user loggined in, check cards for training
    @deck = @card.deck if @card  # if there are some card for training, select deck for links generating
    respond_to do |format|
      format.html
      if @card
        format.json do
          render json: {
            image_url: @card.exemplum.url,
            translated_text: @card.translated_text,
            path: compare_deck_card_path(@deck.id, @card.id),
            card_id: "edit_card_" + @card.id.to_s
                       }
        end
      else
        format.json { render json: { message: t('no_card_to_verify'), no_card: true } }
      end
    end
  end

end
