class User < ActiveRecord::Base
  # e.g., User.authenticate('josh@codedivision.com', 'apples123')
  validates_uniqueness_of :email
  validates :password, :email, :username, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :username, length: { minimum: 5 }

  def self.authenticate(email, password)
    # if email and password correspond to a valid user, return that user
    # otherwise, return nil
    user = self.find_by email: email #find_by can't use count
    if !user.nil?
      if user.password == password
        return user
      end
    end
    return nil
  end
end


# #************** #For testing purpose ***************************
# # irb(main):012:0> user = User.find_by email:"bunny1@gmail.com"   
# # D, [2014-10-28T00:44:03.852937 #421] DEBUG -- :   User Load (0.6ms)  SELECT  "users".* FROM "users"  WHERE "users"."email" = 'bunny1@gmail.com' LIMIT 1  
# => #<User id: 21, username: "bunny1", email: "bunny1@gmail.com", password: "", created_at: "2014-10-27 14:32:21", updated_at: "2014-10-27 14:32:21">     
# # irb(main):004:0> user = User.where email:""    
# #=> #<ActiveRecord::Relation []>                                       
# # irb(main):007:0> user.count                                               
# # D, [2014-10-28T00:39:43.531262 #421] DEBUG -- :    (0.5ms)  SELECT COUNT(*) FROM "users"  WHERE "users"."email" = 'bunny1'                                     
# # => 0   
# # irb(main):002:0> user = User.where email:"bunny1@gmail.com"               
# # D, [2014-10-28T00:38:58.630278 #421] DEBUG -- :   User Load (0.9ms)  SELECT "users".* FROM "users"  WHERE "users"."email" = 'bunny1@gmail.com'                 
# # => #<ActiveRecord::Relation [#<User id: 21, username: "bunny1", email: "bunny1@gmail.com", password: "", created_at: "2014-10-27 14:32:21", updated_at: "2014-10-27 14:32:21">]>                                                        
# # irb(main):003:0> user.count                                               
# # D, [2014-10-28T00:39:08.570434 #421] DEBUG -- :    (1.0ms)  SELECT COUNT(*) FROM "users"  WHERE "users"."email" = 'bunny1@gmail.com'                           
# # => 1  
# # irb(main):011:0> user[0]                                        
# # => #<User id: 21, username: "bunny1", email: "bunny1@gmail.com", password: "", created_at: "2014-10-27 14:32:21", updated_at: "2014-10-27 14:32:21">   
# #************** #For testing purpose ***************************
# # user = self.where email: email #find_by can't use count
# #     if user.count != 0
# #       if user[0].password == password
# #         return user[0]
# #       end
# #     end
# #     return nil
