class OfficeHoursController < ApplicationController
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
  
  
  def create
	@officehour = current_user.office_hours.new(params[:office_hour])
		if @officehour.save
			redirect_to(@officehour, :notice => 'An OfficeHour was successfully created!') 
		else
			render :action => "new"
		end
		
  end
  
  
  def new 
	@officehour = current_user.office_hours.new;
	@courses = current_user.user_courses;
	
  end
  
  
  def edit
	@officehour = current_user.office_hours.find(params[:id])
	
  end
  
  
  def update
	@officehour = current_user.office_hours.find(params[:id])
	
	if @officehour.update_attributes(params[:post])
		redirect_to(@officehour, :notice => 'Post was successfully updated.')
			
	else
		render :action => "edit" 

	end
  end
  

  def destroy
	@officehour = current_user.office_hours.find(params[:id])
	@officehour.destroy
	
	redirect_to(officehours_url)
   end
  
end
