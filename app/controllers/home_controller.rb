class HomeController < ApplicationController
  def index
  	 @card = Card.expired.random.first
  end
end
