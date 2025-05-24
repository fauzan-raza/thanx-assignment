class Reward < ApplicationRecord
    has_many :redemptions

    validates :points_cost, numericality: { greater_than: 0 }
    validates :name, :description, presence: true

    enum :status, { active: 0, inactive: 1, expired: 2 }

    scope :currently_active, -> {
        where(status: 0)
        .where("active_on <= ?", Time.current)
        .where("expiry IS NULL OR expiry > ?", Time.current)
        .order(:id)
    }

    def active?
        status == "active" && active_on.present? && active_on <= Time.current && (expiry.nil? || expiry > Time.current)
    end

    def expired?
        expiry.present? && expiry <= Time.current
    end
end
