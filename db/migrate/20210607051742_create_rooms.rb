class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false, default: ""
      t.references :admin, null: false
      t.string :topic, null: false, default: ""

      t.timestamps

    end

    add_foreign_key :rooms, :users, column: :admin_id

  end
end