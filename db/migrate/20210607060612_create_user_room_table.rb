class CreateUserRoomTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :users, :rooms do |t|
      t.index :user_id
      t.index :room_id
      t.timestamps
    end
  end
end
