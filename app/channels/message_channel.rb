class MessageChannel < ApplicationCable::Channel
  def subscribed
    # binding.pry
    group_id = Group.all.pluck(:id).uniq
    group_id.each do |gr|
      stream_from "message_channel_#{gr}"
    end 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
