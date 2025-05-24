require 'rails_helper'

RSpec.describe Reward, type: :model do
    it "is valid with a name and cost" do
        expect(build(:reward)).to be_valid
    end

    it "is invalid without a name" do
        expect(build(:reward, name: nil)).to_not be_valid
    end
end
