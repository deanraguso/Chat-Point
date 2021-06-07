class Room < ApplicationRecord
    class Room < ApplicationRecord
        belongs_to :admin
        has_many :messages, 
                  dependent: :destroy,
                  inverse_of: :room
        has_and_belongs_to_many :users
      end
end
