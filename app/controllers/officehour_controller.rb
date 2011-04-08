class OfficehourController < ApplicationController
  def index
    @course_department = params[:course_department] || Course.find(:first).department
    @course_number =  params[:course_number] || Course.find(:first).number
    @course_numbers = Course.numbers(@course_department)
    
    # select the current 
    @course = Course.find_by_department_and_number(@course_department,@course_number) 
	  @officehours = @course.office_hours
  end

  def show
	  @officehour = OfficeHour.find(params[:id])
  end

end
