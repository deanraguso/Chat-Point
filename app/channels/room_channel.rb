class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    reject unless params[:room_id]
    room = Room.find params[:room_id].to_i
    stream_for room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
