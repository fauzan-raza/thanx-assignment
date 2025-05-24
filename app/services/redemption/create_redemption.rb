class Redemption::CreateRedemption
    include ActiveModel::Model
  
    attr_accessor :user, :reward_id
  
    validates :user, presence: true
    validates :reward_id, presence: true
  
    attr_reader :redemption, :error_message
  
    def call
        return fail_with(errors.full_messages.to_sentence) unless valid?

        reward = Reward.find_by(id: reward_id)
        return fail_with("Reward not found.") if reward.nil?
        return fail_with("Reward is not available.") unless reward.active? && (reward.expiry.nil? || reward.expiry > Time.current)

        balance = user.point_transactions.sum(:amount)
        return fail_with("Insufficient points.") if balance < reward.points_cost

        ActiveRecord::Base.transaction do
            @redemption = user.redemptions.create!(reward: , redeemed_at: Time.current)
            user.point_transactions.create!(
                amount: -reward.points_cost,
                reason: "reward_redeemed",
                reference: @redemption
            )
        end
  
        true
    rescue ActiveRecord::RecordInvalid => e
        fail_with(e.message)
    end
  
    private
  
    def fail_with(message)
        @error_message = message
        false
    end
end
  