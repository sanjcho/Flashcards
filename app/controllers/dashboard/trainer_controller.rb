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
            card_id: "edit_card_" + @card.id.to_s
                       }
        end
      else
        format.json { render json: { message: t('no_card_to_verify'), no_card: true } }
      end
    end
  end
  
  def compare
    result = CardComparator.call(card: card, compared_text: params[:compared_text], answer_in_time: params[:time])
    result_checkout(result)
    @flash = flash
    respond_to do |format|
      format.js {}
      format.json {}
      format.html {}
    end
  end
  private
  def trainer_params
    params.permit(:comapred_text, :id, :time)
  end

  def result_checkout(result)
    if result.success?         # absolutely right
      flash[:success] = t("success")
    elsif result.type_error?   # right, but some type errors
      flash[:warning] = t("success_with_type_error") + params[:compared_text] + t("what_is_need_to_be_typed") + card.original_text
    elsif result.wrong?        # error
      flash[:danger] = t("wrong")   
    end
  end

  def card
    @card ||= current_user.cards.find(params[:id])
  end
end
