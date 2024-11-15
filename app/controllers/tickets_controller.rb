class TicketsController < ApplicationController
    
    require 'csv'

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

    def tickets_csv #ação para gerar o csv.

        tickets = Ticket.all

        csv_data = CSV.generate(headers:true) do |csv|
            csv << ['ticket_id', 'client_name', 'created_at'] #podemos alterar esses cabeçalhos se quisermos.
            
            tickets.each do |ticket|
                csv << [ticket.id, ticket.client_name, ticket.created_at]
            end
        end

        #aqui vamos enviar o arquivo csv para o usuário que fez o request:
        send_data csv_data, filename: "tickets_report.csv", type: "text/csv"
    end

    private

    def ticket_params
        params.require(:ticket).permit(:client_name)
    end

end
