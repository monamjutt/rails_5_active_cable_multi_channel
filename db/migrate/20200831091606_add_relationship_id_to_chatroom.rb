class AddRelationshipIdToChatroom < ActiveRecord::Migration[5.2]
  def change
    add_column :chatrooms, :relationship_id, :integer
  end
end
