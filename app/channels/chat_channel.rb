# app/channels/chat_channel.rb

class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:channel_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("chat_channel_#{params[:channel_id]}", {
      message: data['message'],
      sender: sender_name
    })
  end

  private

  def identifier
    current_user ? current_user.id : connection.env['rack.session.options'][:id]
  end

  def sender_name
    current_user ? current_user.email.split("@")[0] : 'Anonymous'
  end
end
