require 'rails_helper'

RSpec.describe "Authentication", type: :request do
    describe "POST /api/v1/users (signup)" do
        it "creates a new user" do
            post "/api/v1/users", params: {
                user: { email: "test@example.com", password: "password123" }
            }

            expect(response).to have_http_status(:created)
        end
    end

    describe "POST /api/v1/sessions (signin)" do
        let!(:user) { create(:user, email: "test@example.com", password: "password123") }

        it "returns a token" do
            post "/api/v1/sessions", params: {
                user: { email: "test@example.com", password: "password123" }
            }

            json = JSON.parse(response.body)
            expect(response).to have_http_status(:ok)
            expect(json["access_token"]).to be_present
        end
    end
end
