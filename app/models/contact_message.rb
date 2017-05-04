class ContactMessage < ActiveRecord::Base
    validates :name, presence: true, length: { minimum: 2}
    validates :phone, :presence => {:message => 'Wrong phone number'},
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates :message_content, presence: true, length: { minimum: 5, maximum: 500 }
end
