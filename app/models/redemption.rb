class Redemption < ApplicationRecord
    belongs_to :user
    belongs_to :reward
  
    has_one :point_transaction, as: :reference
  
    validates :redeemed_at, presence: true
end
  