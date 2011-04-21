class RatingsController < ApplicationController
  def create
    @officehour = OfficeHour.find(params[:officehour_id])
    
    if(@officehour.user == current_user)
      flash[:error] = 'You cannot rate yourself.'
      redirect_to(officehour_path(@officehour))
    elsif(@officehour.user_course.ratings.find_by_user_id(current_user.id))
      flash[:error] = 'You cannot rate the same user on the same course more than once.'
      redirect_to(officehour_path(@officehour))
    else
    
      @rating = @officehour.user_course.ratings.new(params[:rating])
      @rating.user = current_user
      
      
    
      if(@rating.save)
        redirect_to(officehour_path(@officehour), :notice => 'Rating was successfully created.')
      else
        redirect_to(officehour_path(@officehour), :error => 'There was an error. Please try again.')
      end
    end
  end

end
