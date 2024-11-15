class MessagesController < ApplicationController
  def index
    ticket = Ticket.find(params[:ticket_id])
    messages = ticket.messages
    render json: messages
  end

  def create
    ticket = Ticket.find(params[:ticket_id])
    message = ticket.messages.build(message_params)
    if message.save
      render json: message, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:sender, :content)
  end
end
