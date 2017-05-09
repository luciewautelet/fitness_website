class StaticPage < ActiveRecord::Base
    has_many :images
    
    validates :title, presence: true, length: { minimum: 1, maximum: 15}
    validates :description, presence: true, length: { minimum: 5, maximum: 50 }
end
