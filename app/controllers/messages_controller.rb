class MessagesController < ApplicationController

  def create
    message = Message.new(message_params)
    reciever = message.chatroom.users.where("users.id != #{current_user.id}").first
    message.user = current_user
    if message.save
      channel = message.chatroom
      MessagesChannel.broadcast_to channel.id,
        message: message.content,
        user: current_user,
        reciever_id: reciever.id,
        chatroom: "#{channel.id}"
      head :ok
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :chatroom_id)
    end
end
