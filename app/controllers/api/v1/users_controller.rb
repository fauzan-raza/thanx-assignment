module Api
    module V1
        class UsersController < ApplicationController
            skip_before_action :authorize_request, only: [:create]
        
            def create
                user = User.new(user_params)
                if user.save
                    token = JwtService.encode(user_id: user.id)
                    render json: { message: "User created successfully" }, status: :created
                else
                    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            def points_balance 
                if @current_user
                    balance = @current_user.current_points
                    render json: { points_balance: balance }
                else
                    render json: { error: "User not found" }, status: :not_found
                end
            end
        
            private
        
            def user_params
                params.require(:user).permit(:name, :email, :password)
            end
        end
    end
end