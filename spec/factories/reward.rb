FactoryBot.define do
    factory :reward do
        name { Faker::Commerce.product_name }
        description { Faker::Lorem.sentence }
        points_cost { rand(10..100) }
        expiry { 1.month.from_now }
        active_on { Time.now }
    end
end