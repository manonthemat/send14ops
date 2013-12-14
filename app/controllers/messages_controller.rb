class MessagesController < ApplicationController
  before_action :signed_in_user

  def index
  end

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      redirect_to :back
    else
      redirect_to root_url
    end
  end

  def destroy
    msg = Message.find(request[:id])
    if msg.user_id == current_user.id
      if msg.viewed != true
        msg.destroy
      else
        flash.now['error'] = 'Message has been viewed already'
      end
    end
    redirect_to :back
  end

  private
    def message_params
      params.require(:message).permit(:content, :recipient)
    end
end
