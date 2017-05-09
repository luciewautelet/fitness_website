class Page < ActiveRecord::Base
    has_many :images
    
    validates :title, presence: true, length: { minimum: 2, maximum: 15}
    validates :description, presence: true, length: { minimum: 5, maximum: 30 }
    validates :content, presence: true, length: { minimum: 5 }
end
