class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels do |t|
      t.integer :chatroom_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
