class IndexController < ApplicationController
  def index
	@officehour = OfficeHours.find(:all)
	
  end

  def about
  end

end
