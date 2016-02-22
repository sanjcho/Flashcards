class HomeController < ApplicationController
  def index
    if current_user
      redirect_to trainer_path
    end
  end
end
