module Api
    module V1
        class RedemptionsController < ApplicationController
            def create
                if @current_user
                    reward = params.require(:reward).permit(:id)
                    service = Redemption::CreateRedemption.new(user: @current_user, reward_id: reward[:id])
                    if service.call
                        render json: { message: "Redemption created successfully", redemption: service.redemption }, status: :created
                    else
                        render json: { error: service.error_message }, status: :unprocessable_entity
                    end
                else
                    render json: { error: "User not found" }, status: :not_found
                end
            end

            def index
                if @current_user
                    redemptions = @current_user.redemptions.includes(:reward).order(created_at: :desc)
                    render json: redemptions, include: :reward
                else
                    render json: { error: "User not found" }, status: :not_found
                end
            end
        end
    end
end