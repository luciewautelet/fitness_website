class Admin < ActiveRecord::Base
    has_secure_password
    validates :password, presence: true, length: { minimum: 5}
    validates :name,  presence: true, length: { maximum: 30 }
end
