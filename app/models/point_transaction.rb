class PointTransaction < ApplicationRecord
    belongs_to :user
    belongs_to :reference, polymorphic: true, optional: true
    
    enum :reason, {
        bonus: "bonus",
        reward_redeemed: "reward_redeemed"
    }, suffix: true

    validates :amount, numericality: { other_than: 0 }
    validates :reason, presence: true, inclusion: { in: reasons.keys }
    validate :amount_sign_must_match_reason
  
    private
  
    def amount_sign_must_match_reason
        if reason == "reward_redeemed" && amount > 0
            errors.add(:amount, "must be negative for redemptions")
        elsif reason == "bonus" && amount < 0
            errors.add(:amount, "must be positive for bonuses")
        end
    end
end
  