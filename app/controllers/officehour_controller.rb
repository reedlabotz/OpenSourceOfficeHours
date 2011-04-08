class OfficehourController < ApplicationController
  def index
    @course_department = Course.find(:first).department
    @course_numbers = Course.numbers(@course_department)
	  @officehours = OfficeHour.find(:all)
  end

  def show
	  @officehour = OfficeHour.find(params[:id])
  end

end
