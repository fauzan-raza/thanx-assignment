require 'rails_helper'

RSpec.describe Redemption, type: :model do
    it "is valid with valid attributes" do
        redemption = build(:redemption)
        expect(redemption).to be_valid
    end

    it "is invalid without a user" do
        redemption = build(:redemption, user: nil)
        expect(redemption).to_not be_valid
    end

    it "is invalid without a reward" do
        redemption = build(:redemption, reward: nil)
        expect(redemption).to_not be_valid
    end
end
