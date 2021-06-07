class MessagesController < ApplicationController
    
    def create
        @message = Message.new(message_params)
        @message.user = current_user
        @room = Room.find(message_params.dig(:room_id))

        respond_to do |format|
            if @message.save
              format.html { redirect_to @room, notice: "Room was successfully created." }
              format.json { render :show, status: :created, location: @room }
            else
              format.html { render :new, status: :unprocessable_entity }
              format.json { render json: @room.errors, status: :unprocessable_entity }
            end
          end
    end

    def update

    end

    def destroy

    end

    private

    def message_params
        params.require(:message).permit(:content, :room_id)
    end
end
