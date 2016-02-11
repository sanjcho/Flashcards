class Result < Struct.new(:diff)
  def success?
  	if diff == 0
  	  return true
  	end
  end

  def type_error?
  	if diff.between?(0, 2) 
  	  return true
  	end
  end

  def wrong?
  	if diff > 2
  	  return true
  	end
  end
end