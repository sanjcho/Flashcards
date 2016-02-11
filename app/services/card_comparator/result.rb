class CardComparator::Result < Struct.new(:diff)

  def success?
  	diff == 0
  end

  def type_error?
  	diff.between?(0, 2) 
  end

  def wrong?
  	diff > 2
  end
end