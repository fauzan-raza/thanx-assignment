class User < ApplicationRecord
    has_secure_password
 
    validates :email, presence: true, uniqueness: true,
                format: { with: URI::MailTo::EMAIL_REGEXP }

    has_many :point_transactions, dependent: :destroy
    has_many :redemptions, dependent: :destroy
    has_many :rewards, through: :redemptions
  
    def current_points
        point_transactions.sum(:amount)
    end
end
  