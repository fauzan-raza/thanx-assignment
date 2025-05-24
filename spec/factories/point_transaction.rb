FactoryBot.define do
    factory :point_transaction do
        user
        reason { "bonus" }
        reference { nil }
        amount { 100 }
    end
end