require 'rails_helper'

RSpec.describe "Rewards", type: :request do
    let!(:user) { create(:user) }
    let!(:token) { JwtService.encode(user_id: user.id) }

    before do
        create_list(:reward, 3)
    end

    it "returns available rewards" do
        get "/api/v1/rewards", headers: {
            "Authorization" => "Bearer #{token}"
        }
        
        json = JSON.parse(response.body)
        rewards = json["rewards"]
        expect(response).to have_http_status(:ok)
        expect(rewards.length).to eq(3)
    end
end

