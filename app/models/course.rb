class Course < ActiveRecord::Base
  has_many :user_courses
  has_many :office_hours, :through => :user_courses
  
  def short_name
    self.department + " " + self.number
  end
  
  def self.departments
    @depratmets = Course.find_by_sql("SELECT department FROM courses GROUP BY department ORDER BY department").map{|c| c.department}
  end
  
  def self.numbers(department)
    Course.find_by_sql("SELECT number FROM courses WHERE department='" + department + "' GROUP BY number ORDER BY number").map{|c| c.number}
  end
  
  def self.years
    @years = ["Fall 2009","Spring 2010","Fall 2010","Spring 2011"]
  end
end
