class User < ActiveRecord::Base
  # e.g., User.authenticate('josh@codedivision.com', 'apples123')
   validates_uniqueness_of :email
   validates :password, :email, presence: true
   validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  
  def self.authenticate(email, password)
    # if email and password correspond to a valid user, return that user
    # otherwise, return nil
    user = User.find_by email: email
    puts user.password
    puts password
    if user.password == password
      return true
    else
      return false
    end
  
  end
end