class RemoveTopicFromChatroom < ActiveRecord::Migration[5.2]
  def change
    remove_column :chatrooms, :topic
  end
end
