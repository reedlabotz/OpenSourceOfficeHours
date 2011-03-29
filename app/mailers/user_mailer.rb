class UserMailer < ActionMailer::Base
  default :from => "OSOH <reedlabotz@gmail.com>"
  
  def registration_confirmation(user)
    @user = user
    @activation_url = user_activate_path(@user)
    mail(:to => user.email, :subject => "Welcome to OSOH")
  end
end
