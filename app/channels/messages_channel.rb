class MessagesChannel < ApplicationCable::Channel  
  # def subscribed
  #   c = Chatroom.first
  #   stream_from "chatroom_#{c.id}:messages"
  # end
  def subscribed
    # stream_from "some_channel"
    stream_for chatroom
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    stop_all_streams
  end

  private

  # any activerecord instance has 'to_gid_param'
  def chatroom
    # puts "\n" *8
    # p params[:resource]
    Chatroom.find_by(id: params[:room_id]).id
  end
end  
