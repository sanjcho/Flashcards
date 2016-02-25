class CardComparator::Result < Struct.new(:q)

  def success?
  	q.between?(3, 5)
  end

  def type_error?
  	q.between?(1, 2)
  end

  def wrong?
  	q == 0
  end
end