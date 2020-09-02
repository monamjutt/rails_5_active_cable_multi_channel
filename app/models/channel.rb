class Channel < ApplicationRecord
  belongs_to :chatroom, class_name: "Chatroom"
end
