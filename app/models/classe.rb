class Classe < ActiveRecord::Base
    belongs_to :admin
    
    validates :ctype, presence: true, length: { minimum: 2}
    validates_inclusion_of :start, presence: true, :in => [true, false]
    validates :date,  presence: true
    validates :description, presence: true, length: { minimum: 2, maximum: 200 }

end
