class ChatsController < ApplicationController
  before_action :require_login
  
  def index
    @groups = Group.where("grp_members @> ?", "{#{current_user.id}}")

    user_ids = @groups.pluck(:grp_members).flatten.map(&:to_i)
    @users = User.where(id: user_ids).where.not(id: current_user.id)
  end

  def create_group
   @created_group = Group.create(
      g_name: params[:g_name],
      created_by: current_user.id,
      group_type: "group", 
      grp_members: params[:selected_members]
    )

    if @created_group
      redirect_to chats_path
    end
  end

  def show_chats
    @group = Group.find_by(id: params[:group_id])
    group_name    
    
    @chats = Chat.where(group_id: params[:group_id])
    respond_to do |format|
      format.html {redirect_to chats_path}
      format.js
    end
  end

  def send_messages
    @message = Chat.create(m_body: params[:m_body],
      sender_id: current_user.id,
      group_id:params[:group_id]
    )
    message = @message
    ActionCable.server.broadcast("message_channel_#{message.group_id}",
      {
        message: message,
        current_user: current_user.name
      }
    )

    respond_to do |format|
      format.js {SendMessageJob.perform_later(message)}
    end
  end

  def delete_message
    @delete_message = Chat.find(params[:id])
    @delete_message.destroy
    redirect_to chats_path
  end

  private
  def group_name
    @group_name = case @group.group_type
    when "personal"
      User.find_by(id: (@group.grp_members - [current_user.id.to_s]).first ).name
    when "group"
      @group.g_name
    end
  end

  def message_params
    params.require(:chat).permit(:m_body)
    params.require(:group).permit(:g_name)
  end
end
