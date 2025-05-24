require 'rails_helper'

RSpec.describe "Redemptions API", type: :request do
    let(:user) { create(:user) }
    let!(:point_transaction) { create(:point_transaction, user: user) }
    let(:token) { JwtService.encode(user_id: user.id) }
    let(:headers) { { "Authorization" => "Bearer #{token}" } }

    describe "GET /api/v1/users/redemptions" do
        before do
            create_list(:redemption, 3, user: user)
            get "/api/v1/users/redemptions", headers: headers
        end

        it "returns redemptions" do
            json = JSON.parse(response.body)
            redemptions = json["redemptions"]
            expect(response).to have_http_status(:ok)
            expect(redemptions.size).to eq(3)
        end
    end

    describe "POST /api/v1/users/redemptions" do
        let(:reward) { create(:reward) }

        context "with valid parameters" do
            it "creates a new redemption" do
                expect {
                    post "/api/v1/users/redemptions", params: { reward: { id: reward.id } }, headers: headers
                }.to change(Redemption, :count).by(1)

                expect(response).to have_http_status(:created)
                expect(JSON.parse(response.body)["message"]).to eq("Redemption created successfully")
            end
        end

        context "with invalid parameters" do
            it "returns an error" do
                post "/api/v1/users/redemptions", params: { reward: { id: nil } }, headers: headers

                expect(response).to have_http_status(:unprocessable_entity)
                expect(JSON.parse(response.body)["error"]).to be_present
            end
        end

        context "with inactive reward" do
            it "returns an error" do
                inactive_reward = create(:reward, status: "inactive")

                post "/api/v1/users/redemptions", params: { reward: { id: inactive_reward.id } }, headers: headers

                expect(response).to have_http_status(:unprocessable_entity)
                expect(JSON.parse(response.body)["error"]).to eq("Reward is not available.")
            end
        end

        context "with insufficient points" do
            it "returns an error" do
                expensive_reward = create(:reward, points_cost: 10_000)

                post "/api/v1/users/redemptions", params: { reward: { id: expensive_reward.id } }, headers: headers

                expect(response).to have_http_status(:unprocessable_entity)
                expect(JSON.parse(response.body)["error"]).to eq("Insufficient points.")
            end
        end
    end
end
