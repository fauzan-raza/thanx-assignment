# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

puts "🌱 Seeding data..."

user = User.find_or_create_by!(email: "test@example.com") do |u|
    u.name = "Test User"
    u.password = "password"
end

puts "✅ Created user: #{user.email} / password"

reward1 = Reward.find_or_create_by!(name: "Free Coffee") do |r|
    r.description = "A free drink"
    r.points_cost = 50
    r.status = :active
    r.active_on = Time.current
    r.expiry = 2.weeks.from_now
end

reward2 = Reward.find_or_create_by!(name: "T-shirt") do |r|
    r.description = "Cool swag tee"
    r.points_cost = 100
    r.status = :active
    r.active_on = Time.current
    r.expiry = 1.month.from_now
end

PointTransaction.find_or_create_by!(user: user, amount: 200, reason: :bonus)

puts "🎁 Seeded rewards:"
puts "  - #{reward1.name} (#{reward1.points_cost} pts)"
puts "  - #{reward2.name} (#{reward2.points_cost} pts)"

puts "💰 User #{user.email} awarded 200 bonus points"
puts "✅ Done seeding!"

