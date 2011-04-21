require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :user_courses
  has_many :courses, :through => :user_courses
  has_many :office_hours, :through => :user_courses
  
  has_many :ratings, :through => :user_courses
  
  
  
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken


  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message
  validates_presence_of     :first_name
  validates_presence_of     :last_name

  before_create :make_activation_code 

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name

  def displayname
    self.first_name + " " + self.last_name
  end


  # Activates the user in the database.
  def activate!
    @activated = true
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(false)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  def active?
    # the existence of an activation code means they have not activated yet
    activation_code.nil?
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    u = find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email] # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end
  
  
  
  def score
    num_office_hours = self.office_hours.count                             ## num office hours held    12.5%
    ave_rating = self.ratings.average(:number)                             ## average rating           75%
    num_ratings_made = Rating.count(:conditions => "user_id = 'self.id'")  ## number of comments made  12.5%
    
    max_office_hours = ActiveRecord::Base.connection.select_one('SELECT MAX(count) AS count FROM(SELECT COUNT(*) AS count FROM "office_hours" INNER JOIN "user_courses" ON "office_hours".user_course_id = "user_courses".id GROUP BY "user_courses".user_id = 1)').count
                                                                           ## max office hours held
    max_ratings_made = ActiveRecord::Base.connection.select_one('SELECT MAX(count) as count FROM(SELECT COUNT(*) AS count FROM "ratings" GROUP BY user_id)').count
                                                                           ## max comments made
    
    (((num_office_hours/max_office_hours) * 10 * 0.125) + (ave_rating * 0.75) + ((num_ratings_made/max_ratings_made) * 10 * 0.125))
  end

  
    protected
      def make_activation_code
            self.activation_code = self.class.make_token
      end
  
end
