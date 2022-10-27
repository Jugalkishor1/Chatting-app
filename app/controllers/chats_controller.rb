class ChatsController < ApplicationController
  def index
    a = Group.where("grp_members @> ?", "{#{current_user.id}}").pluck(:grp_members).flatten.map(&:to_i)
    @groups = User.where(id: a).where.not(id: current_user.id)
  end

  def show_chats
    @group = Group.where("grp_members @> ?", "{#{current_user.id}, #{params[:friend_id].to_i} }").last
    @friend_id = params[:friend_id].to_i
    @message_reciever = User.find_by(id: @friend_id)
    @chats = Chat.where(group_id: @group.id)
    respond_to do |format|
      format.html {redirect_to chats_path}
      format.js
    end
  end

  def send_messages
    group = Group.where("grp_members @> ?", "{#{current_user.id}, #{params[:friend_id].to_i} }").last
    @message = Chat.create(m_body: params[:m_body], sender_id: current_user.id, group_id: group.id)

    respond_to do |format|
      format.html {redirect_to chats_path}
      format.js
    end
  end

  private
  def message_params
      # debugger
      params.require(:chat).permit(:m_body)
    end
  end
