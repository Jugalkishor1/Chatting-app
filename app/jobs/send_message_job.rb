class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    html = "<p>#{message.sender.name}: #{message.m_body}</p>"
    group_id = [message.sender_id, message.group_id].sort.join("")
    # binding.pry
    ActionCable.server.broadcast("message_channel_#{group_id}", "#{html}")
  end
end
