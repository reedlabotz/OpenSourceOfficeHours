class OfficehourController < ApplicationController
  def index
	@officehours = OfficeHour.find(:all)
  end

  def show
	@officehour = OfficeHour.find(params[:id])
  end

end
