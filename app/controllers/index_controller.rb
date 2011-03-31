class IndexController < ApplicationController
  skip_before_filter :login_required
  
  def index
    if current_user != nil
      redirect_to "/courses"
    end	
  end

  def about
    
  end
  
  

end
