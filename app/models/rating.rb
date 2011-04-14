class Rating < ActiveRecord::Base
  belongs_to :user_course
  belongs_to :user
end
