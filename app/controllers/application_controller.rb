class ApplicationController < ActionController::API
    before_action :authenticate_api

    private
  
    def authenticate_api
      token = request.headers['Authorization']
      if token != "Bearer wh1zzt3ch"
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
end
