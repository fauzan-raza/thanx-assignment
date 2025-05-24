require 'rails_helper'

RSpec.describe PointTransaction, type: :model do
    describe "associations" do
        it { should belong_to(:user) }
        it { should belong_to(:reference).optional }
    end

    describe "validations" do
        it { should validate_numericality_of(:amount).is_other_than(0) }
        it { should validate_presence_of(:reason) }

        context "amount_sign_must_match_reason" do
            let(:user) { User.create!(name: "Test", email: "test@example.com", password: "password") }

            it "is invalid if reason is 'reward_redeemed' and amount is positive" do
                tx = PointTransaction.new(user:, reason: "reward_redeemed", amount: 10)
                expect(tx).to be_invalid
                expect(tx.errors[:amount]).to include("must be negative for redemptions")
            end

            it "is invalid if reason is 'bonus' and amount is negative" do
                tx = PointTransaction.new(user:, reason: "bonus", amount: -5)
                expect(tx).to be_invalid
                expect(tx.errors[:amount]).to include("must be positive for bonuses")
            end

            it "is valid for 'reward_redeemed' with negative amount" do
                tx = PointTransaction.new(user:, reason: "reward_redeemed", amount: -10)
                expect(tx).to be_valid
            end

            it "is valid for 'bonus' with positive amount" do
                tx = PointTransaction.new(user:, reason: "bonus", amount: 10)
                expect(tx).to be_valid
            end
        end
    end
end
