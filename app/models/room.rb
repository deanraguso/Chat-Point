class Room < ApplicationRecord
  belongs_to :admin
  has_many :messages, 
            dependent: :destroy,
            inverse_of: :room
end
