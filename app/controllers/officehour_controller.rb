class OfficehourController < ApplicationController
  def index
    @course_department = params[:course_department] || "All"
    @course_number =  params[:course_number] || "Select Department"
    @course_numbers = Course.numbers(@course_department)
    
    # select the current
    if(@course_department == "All")
      @officehours = OfficeHour.all
    else  
      @course = Course.find_by_department_and_number(@course_department,@course_number) 
	    @officehours = @course.office_hours
    end
  end

  def show
	  @officehour = OfficeHour.find(params[:id])
	  @ratings = @officehour.user_course.ratings.all
	  @rating = Rating.new
  end

end
