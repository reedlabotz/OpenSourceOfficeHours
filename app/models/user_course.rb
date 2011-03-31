class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  attr_accessible :department, :number
  
  def department
      self.course.department
  end
  def number
      self.course.number
  end
end
