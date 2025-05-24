require 'rails_helper'

RSpec.describe "Users API", type: :request do
    let(:user) { create(:user) }
    let!(:transactions) do
        create(:point_transaction, user: user, amount: 100)
        create(:point_transaction, user: user, amount: -40, reason: "reward_redeemed")
    end
    let(:token) { JwtService.encode(user_id: user.id) }
    let(:headers) { { "Authorization" => "Bearer #{token}" } }

    describe "GET /api/v1/users/points_balance" do
        context "when authorized" do
            it "returns the correct points balance" do
                get "/api/v1/users/points_balance", headers: headers

                expect(response).to have_http_status(:ok)
                json = JSON.parse(response.body)
                expect(json["points_balance"]).to eq(60)
            end
        end

        context "when unauthorized" do
            it "returns a 404 with error message" do
                get "/api/v1/users/points_balance"

                expect(response).to have_http_status(:not_found)
                json = JSON.parse(response.body)
                expect(json["error"]).to eq("User not found")
            end
        end
    end
end
