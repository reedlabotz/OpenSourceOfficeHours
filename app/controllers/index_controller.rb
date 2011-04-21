class IndexController < ApplicationController
  skip_before_filter :login_required
  
  def index
    if logged_in?
      redirect_to office_hours_path
    end	
  end

  def about
    
  end
  
  

end
