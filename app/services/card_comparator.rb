class CardComparator
  
  # here we make all correct and wrong answer counting 
  # and calculate a date/time of a next card review
  # as well as we tell: if the answer is correct - true, otherwize - false

  def initialize(params)
    @card = params[:card]
    @compared_text = params[:compared_text]
  end

  def self.call(params)
  	 Result.new(new(params).diff)
  end

  def diff
  	difference = DamerauLevenshtein.distance(@card.original_text.downcase.strip, @compared_text.downcase.strip, 1, 2)
    if  difference <= 2  # is the answer right?
      update_card_attr_right!(@card)   # yes, so update correct, reset wrong counters, return true
  	else
      check_on_error!(@card)       # oh, no, so update wrong counter, return false
  	end
    return difference
  end

  def update_card_attr_right!(card)
    review = review_date_calc(card.correct)
    card.update(review_date: review, correct: card.correct + 1, wrong: 0)
  end

  def review_date_calc(count)
    if count == 0
      12.hours.from_now
    elsif count == 1
      3.days.from_now
    elsif count == 2
      7.days.from_now
    elsif count == 3
      14.days.from_now
    elsif count >= 4
      1.month.from_now
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