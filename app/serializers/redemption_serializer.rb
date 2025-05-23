class RedemptionSerializer < ActiveModel::Serializer
    attributes :id, :redeemed_at, :created_at

    belongs_to :reward, serializer: RewardSerializer
end
