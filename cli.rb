require 'thor'
require 'httparty'
require 'json'

class ApiCLI < Thor
  BASE_URL = "http://localhost:3000/api/v1"

  desc "signup EMAIL PASSWORD", "Sign up a new user"
  def signup(email, password)
    response = HTTParty.post("#{BASE_URL}/users", body: {
      user: { email: email, password: password }
    }.to_json, headers: default_headers)

    handle_response(response)
  end

  desc "signin EMAIL PASSWORD", "Sign in a user and store the token"
  def signin(email, password)
    response = HTTParty.post("#{BASE_URL}/sessions", body: {
      user: { email: email, password: password }
    }.to_json, headers: default_headers)

    if response.code == 200 && response.parsed_response["access_token"]
      File.write(".token", response.parsed_response["access_token"])
      puts "✅ Logged in successfully. Access Token saved."
    else
      handle_response(response)
    end
  end

  desc "points balance", "Get current user points balance"
  def points_balance
    token = read_token
    response = HTTParty.get("#{BASE_URL}/users/points_balance", headers: auth_headers(token))
    handle_response(response)
  end

  desc "available rewards", "Get available rewards"
  def available_rewards
    token = read_token
    response = HTTParty.get("#{BASE_URL}/rewards", headers: auth_headers(token))
    handle_response(response)
  end

  desc "reward redemptions", "Get user reward redemptions"
  def reward_redemptions
    token = read_token
    response = HTTParty.get("#{BASE_URL}/users/redemptions", headers: auth_headers(token))
    handle_response(response)
  end

  desc "redeem rewards", "Redeem rewards"
  def redeem_reward(reward_id)
    token = read_token
    response = HTTParty.post("#{BASE_URL}/users/redemptions", body: {
      reward: { id: reward_id }
    }.to_json, headers: auth_headers(token))
    handle_response(response)
  end

  private

  def default_headers
    { "Content-Type" => "application/json" }
  end

  def auth_headers(token)
    default_headers.merge({ "Authorization" => "Bearer #{token}" })
  end

  def read_token
    File.read(".token").strip
  rescue
    puts "❌ You need to sign in first using `signin`"
    exit
  end

  def handle_response(response)
    puts "Status: #{response.code}"
    puts JSON.pretty_generate(response.parsed_response)
  end
end

ApiCLI.start(ARGV)
