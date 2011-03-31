class CoursesController < ApplicationController
  # GET /user_courses
  # GET /user_courses.xml
  def index
    @user_courses = current_user.user_courses.all
  end


  # GET /user_courses/new
  # GET /user_courses/new.xml
  def new
    @user_course = UserCourse.new
    @user_course.course = Course.find(:first)
    @numbers = Course.numbers(@user_course.department)
  end

  # GET /user_courses/1/edit
  def edit
    @user_course = current_user.user_courses.find(params[:id])
    @numbers = Course.numbers(@user_course.department)
  end

  # POST /user_courses
  # POST /user_courses.xml
  def create
    @user_course = current_user.user_courses.new(params[:user_course])

      if @user_course.save
        redirect_to(user_courses_url, :notice => 'User course was successfully created.')
      else
        render :action => "new"
      end
  end

  # PUT /user_courses/1
  # PUT /user_courses/1.xml
  def update
    @user_course = current_user.user_courses.find(params[:id])
    
      if @user_course.update_attributes(params[:user_course] && @user_course.course = Course.find_by_department_and_number(params[:user_course][:department],params[:user_course][:number]))
       redirect_to(user_courses_url, :notice => 'User course was successfully updated.')
      else
        render :action => "edit"
      end
  end

  # DELETE /user_courses/1
  # DELETE /user_courses/1.xml
  def destroy
    @user_course = current_user.user_courses.find(params[:id])
    @user_course.destroy

    redirect_to(user_courses_url)
  end
end
