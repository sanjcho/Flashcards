class CardComparator
  
  # here we make all correct and wrong answer counting 
  # and calculate a date/time of a next card review
  # as well as we tell: if the answer is correct - true, otherwize - false

  def initialize(params)
    @card = params[:card]
    @compared_text = params[:compared_text]
  end

  def self.call(params)
  	new(params).right?
  end

  def right?
  	if @card.original_text.downcase.strip == @compared_text.downcase.strip  # is the answer right?
      update_review_date!(@card)   # yes, so update correct, reser wrong counters, return true
      return true
  	else
      check_on_error!(@card)       # oh, no, so update wrong counter, return false
      return false
  	end

  end

  def update_review_date!(card)
    review = review_date_calc(card.correct)
    card.update(review_date: review, correct: card.correct + 1, wrong: 0)
  end

  def review_date_calc(count)
    if count == 0
      DateTime.now.in_time_zone("Ekaterinburg") + 12.hours
    elsif count == 1
      DateTime.now.in_time_zone("Ekaterinburg") + 3.days
    elsif count == 2
      DateTime.now.in_time_zone("Ekaterinburg") + 7.days
    elsif count == 3
      DateTime.now.in_time_zone("Ekaterinburg") + 14.days
    elsif count >= 4
      DateTime.now.in_time_zone("Ekaterinburg") + 1.month
    end
  end

  def check_on_error!(card)
    if card.wrong >= 2  #is there a lot of error made?
      card.update(correct: 0, wrong: 0 )
    else
      card.update(wrong: card.wrong + 1 )
    end
  end

end