class ApplicationController < ActionController::API
    before_action :authorize_request
    attr_reader :current_user

    private

    def authorize_request
        header = request.headers["Authorization"]
        token = header.split(" ").last if header
        decoded = JwtService.decode(token)
        @current_user = User.find_by(id: decoded[:user_id]) if decoded
    rescue
        render json: { errors: "Unauthorized" }, status: :unauthorized
    end
end
