module Api
    module V1
        class RewardsController < ApplicationController
            def index
                rewards = Reward.currently_active
                            .page(params[:page] || 1)
                            .per(params[:per_page] || 10)
                
                render json: rewards, meta: pagination_meta(rewards)
            end

            private

            def pagination_meta(object)
                {
                current_page: object.current_page,
                next_page: object.next_page,
                prev_page: object.prev_page,
                total_pages: object.total_pages,
                total_count: object.total_count
                }
            end
        end
    end
end