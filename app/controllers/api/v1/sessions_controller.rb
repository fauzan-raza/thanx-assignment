module Api
    module V1
        class SessionsController < ApplicationController
            skip_before_action :authorize_request

            def create
                credentials = params.require(:user).permit(:email, :password)
                user = User.find_by(email: credentials[:email])

                if user&.authenticate(credentials[:password])
                    token = JwtService.encode(user_id: user.id)
                    render json: { access_token: token }
                else
                    render json: { error: "Invalid email or password" }, status: :unauthorized
                end
            end
        end
    end
end
