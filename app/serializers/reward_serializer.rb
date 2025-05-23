class RewardSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :points_cost, :expiry, :active_on, :status
end
