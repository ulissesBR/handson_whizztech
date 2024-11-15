class TicketsController < ApplicationController
    def index
        tickets = Ticket.all
        render json: tickets
    end

    def create
        ticket = Ticket.new(ticket_params)
        if ticket.save
            render json: ticket, status: :created
        else
            render json: { errors: ticket.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def ticket_params
        params.require(:ticket).permit(:client_name)
    end
    
end
