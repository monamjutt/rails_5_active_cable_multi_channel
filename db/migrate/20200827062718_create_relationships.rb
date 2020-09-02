class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.integer :type_id
      t.integer :chatroom_id

      t.timestamps
    end
  end
end
