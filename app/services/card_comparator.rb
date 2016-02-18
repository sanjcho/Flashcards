class CardComparator
  
  # here we use a SuperMemo2 algorithm
  # to read more about it, follow the link https://www.supermemo.com/english/ol/sm2.htm

  def initialize(params)
    @card = params[:card]
    @compared_text = params[:compared_text]
  end

  def self.call(params)
  	 Result.new(new(params).qualify)
  end

  def qualify
  	difference = DamerauLevenshtein.distance(@card.original_text.downcase.strip, @compared_text.downcase.strip, 1, 2)
    length = @card.original_text.strip.length
    q = get_quality(difference, length).to_i
    @card.update(review_date_calc(q))
    return q
  end

  def review_date_calc(q)
    if q < 3
      {    repeate: 1,
       review_date: 1.day.from_now,
          interval: 1
      }
    else
      efactor = efactor_calc(q, @card.e_factor) if @card.repeate >= 3
      efactor = @card.e_factor if @card.repeate < 3
      interval = interval_calc(@card.interval, efactor, @card.repeate)
      {
      e_factor: efactor,
      interval: interval,
      repeate: @card.repeate+1,
      review_date: @card.interval.days.from_now
      }
    end
  end

  def interval_calc(interval, e_factor, repeate)
    return 1 if repeate == 1
    return 6 if repeate == 2
    interval*e_factor
  end

  def efactor_calc(q, efactor)
    new_efactor = efactor-0.8+0.28*q-0.02*q*q
    new_efactor < 1.3 ? 1.3 : new_efactor
  end

  def get_quality(diff, length)
    percent = ((diff.to_f / length) * 100)
    if  percent == 0              # until we have no jQuery timer, we think all answer "perfectly correct"
     5    
    elsif percent.between?(1, 10)   # incorrect answer with a little error
     2
    elsif percent.between?(11, 20)   # incorrect answer with rather significant error
     1
    elsif percent < 21               # absolytely incorrect answer
     return 0
    end
  end
end