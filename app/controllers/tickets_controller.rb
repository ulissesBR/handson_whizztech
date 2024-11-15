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

    def tickets_count
        start_date = params[:start_date].to_date
        end_date = params[:end_date].to_date

        count = Ticket.where(created_at: start_date.beginning_of_day..end_date.end_of_day).count

        render json: { tickets_count: count }
    end
    private

    def ticket_params
        params.require(:ticket).permit(:client_name)
    end

end
