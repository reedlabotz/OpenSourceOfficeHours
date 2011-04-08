class IndexController < ApplicationController
  skip_before_filter :login_required
  
  def index
    if logged_in?
      redirect_to "/officehour"
    end	
  end

  def about
    
  end
  
  

end
