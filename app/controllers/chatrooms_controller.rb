class ChatroomsController < ApplicationController

  def index
    @chatroom = Chatroom.new
    @chatrooms = []
    relationships = current_user.relationships.preload(:friend).where(:type_id => 1)
    @chatroom_records = []
    relationships.each do |relationship|
      chatroom = relationship.chatroom
      if chatroom.present?
       @chatroom_records.push({
          "id": relationship.chatroom.id,
          "friend_name": relationship.friend.username
        })
      end
    end
  end

  def new
    if request.referrer.split("/").last == "chatrooms"
      flash[:notice] = nil
    end
    @chatroom = Chatroom.new
  end

  def edit
    @chatroom = Chatroom.find_by(slug: params[:slug])
  end

  def create
    # TO create chatroom, first you have to create friend relationship of users
    # To see chatroom on either side you've to create relationship (For this currently we have no UI, so we've to run query manuall)
    # To create Realationship
    # user1 = User.find(1)
    # user2 = User.find(2)
    # r = Relationship.new
    # r.user = user1
    # r.friend = user2
    # r.type = Type.first (By default First type is friend)
    # r.save
    # after creating chatroom
    # user1.relationship << chatroom
    error = nil
    if params[:topic]
      user = User.where('username = ?', "#{params[:topic].gsub(" ", "")}")
      @conversation_username = params[:topic].gsub(" ", "") if user
      relationship = user.present? ? current_user.relationships.where(:friend_id => user.first.id, :type_id => 1) : []
      if relationship.present?
        friend_has_relationship = user.first.relationships.where(:friend_id => current_user.id)
        if friend_has_relationship.present?
          @chatroom = Chatroom.find(friend_has_relationship.first.chatroom_id)
        else
          @chatroom = Chatroom.new(:relationship_id => relationship.first.id)
          @chatroom.save
          @chatroom.reload
          relationship.first.chatroom_id = @chatroom.id
          relationship.first.save
        end
        if @chatroom
          current_user.chatrooms << @chatroom
          respond_to do |format|
            format.html { redirect_to @chatroom }
            format.js
          end
        else
          error = ["Couldn't create chatroom"]
        end
      else
        error = ["User is not friend with this person"]
      end
    else
      error = ["Please provide valid params"]
    end

    flash[:notice] = {error: error} if error

    if flash[:notice].present?
      respond_to do |format|
        flash[:notice]
        format.html { redirect_to @chatroom }
        format.js
      end
    end
  end

  def update
    chatroom = Chatroom.find_by(slug: params[:slug])
    chatroom.update(chatroom_params)
    redirect_to chatroom
  end

  def show
    @chatroom = Chatroom.find_by(id: params[:id])
    @message = Message.new
  end
end
