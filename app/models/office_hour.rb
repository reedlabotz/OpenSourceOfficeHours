class OfficeHour < ActiveRecord::Base
  belongs_to :user_course
  has_one :course, :through => :user_course
  has_one :user, :through => :user_course

  validates_presence_of :user_course
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :location
end
