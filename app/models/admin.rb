class Admin < ActiveRecord::Base
    has_secure_password
    validates :password, presence: true, length: { minimum: 5}
    validates :name,  presence: true, length: { maximum: 30 }
    
    
    # TODO: find how to do that
    # after_create :default_values
    
    # def default_values
    #     print "IN DEFAULT VALUES OF ADMIN MODEL"
    #     self.admin_all = false if self.admin_all.nil?
    # end
end
