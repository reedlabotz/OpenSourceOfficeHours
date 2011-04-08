class OfficeHour < ActiveRecord::Base
  belongs_to :user_course
  has_one :course, :through => :user_course
  has_one :user, :through => :user_course
end
