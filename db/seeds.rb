# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create!(name: "Test User", email: "test@example.com", password: "password")

reward1 = Reward.create!(name: "Free Coffee", description: "A free drink", points_cost: 50, status: :active, active_on: Time.now, expiry: 2.weeks.from_now)
reward2 = Reward.create!(name: "T-shirt", description: "Cool swag tee", points_cost: 100, status: :active, active_on: Time.now, expiry: 1.month.from_now)

PointTransaction.create!(user: user, amount: 200, reason: "bonus")
