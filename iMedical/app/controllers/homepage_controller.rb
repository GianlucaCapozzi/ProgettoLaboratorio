class HomepageController < ApplicationController

  def index
      if logged_in?
          redirect_to "/home/show"
      end
  end


end
