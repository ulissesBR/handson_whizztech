Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :tickets, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  # rota implementada para contagem dos tickets em um intervalo de datas:
  get 'api/v1/reports/tickets_count', to: 'tickets#tickets_count'

  # rota implementada para exportação dos tickets como csv
  get 'api/v1/reports/tickets.csv', to: 'tickets#tickets_csv'
  
end
