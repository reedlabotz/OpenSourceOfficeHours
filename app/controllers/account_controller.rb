class AccountController < ApplicationController
  include AuthenticatedSystem
  skip_before_filter :login_required, :only => [:new, :create, :activate]
  
  # For editing current accounts
  
  def index
  end
  
  def password
    @user = current_user
  end
  
  def update
      @user = current_user
      if @user.update_attributes(params[:user])
        redirect_to("/account", :notice => 'Your account was successfully updated.')
      else
        render :action => "edit"
      end
  end
  
  
  #def destroy
  #  current_user.destroy
  #  logout_keeping_session!
  #  redirect_to(:login, :notice => "Your account has been deleted.")
  #end
  
  
  # For creating new accounts
  
  def new
    @user = User.new
  end

  def create
    logout_keeping_session!
    
    
    @user = User.new(params[:user])
    
    success = @user.save
    
    if success && @user.errors.empty?
      UserMailer.registration_confirmation(@user).deliver
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_to('/')
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def destroy
    @user_courses = current_user.user_courses.all
    
    # delete all user courses
    @user_courses.each do |c|
      # delete all ratings about this user
      @ratings = c.ratings.all
      @ratings.each do |r|
        r.destroy
      end
      
      # delete all office hours held by this user
      @officehours = c.office_hours.all
      @officehours.each do |o|
        o.destroy
      end

      c.destroy
    end
    
    # delete all ratings made by this user
    @ratings = current_user.ratings.all
    @ratings.each do |r|
      r.destroy
    end
    @user = current_user
    
    logout_killing_session!
    @user.destroy
    flash[:notice] = "Your account has been deleted from our system."
    redirect_to '/'
  end

end

