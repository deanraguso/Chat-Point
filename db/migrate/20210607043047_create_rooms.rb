class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false, default: ""
      t.references :admin, null: false, foreign_key: {to_table: :users }
      t.string :topic, null: false, default: ""

      t.timestamps
    end
  end
end
