class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course


  def department
      self.course.department
  end
  def number
      self.course.number
  end
end
