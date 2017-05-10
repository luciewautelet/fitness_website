class Image < ActiveRecord::Base
    
    validates :gallery, presence: true, length: { minimum: 1, maximum: 20}
    validates :filename,  presence: true
    validates :alt_text,  presence: true, length: { maximum: 15}
    validates :caption, presence: true, length: { minimum: 2, maximum: 50 }
end
