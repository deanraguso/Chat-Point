class Room < ApplicationRecord
    belongs_to :admin, foreign_key: "admin_id", class_name: "User"
    has_many :messages, 
                dependent: :destroy,
                inverse_of: :room
                
    has_and_belongs_to_many :users

end
