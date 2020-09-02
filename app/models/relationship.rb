class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  belongs_to :type

  def chatroom
    Chatroom.find_by_id(self.chatroom_id)
  end
end
