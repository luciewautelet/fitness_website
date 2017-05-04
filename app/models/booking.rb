class Booking < ActiveRecord::Base
    belongs_to :classe
    
    validates :classe_type, presence: true, length: { minimum: 2}
    validates :cdate,  presence: true
    validates :name, presence: true, length: { minimum: 2}
    validates :phone, :presence => {:message => 'Need phone number'},
                     :numericality => true,
                     :length => { :minimum => 10, :maximum => 15 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
    validates_inclusion_of :member, presence: true, :in => [true, false]
end
