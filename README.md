# Thanx Assignment
A Ruby on Rails API application with a command-line interface (CLI) for user authentication, points tracking, and reward redemption.

## 🚀 Features
- User sign-up and sign-in (with JWT-based authentication)

- View current points balance

- Browse and redeem rewards

- Command-line interface (CLI) to interact with the API

## 🛠️ Requirements
- Ruby: >= 3.0

- Rails: >= 7.0

- Bundler

- SQLite3 (default Rails development DB)

## 🧰 Setup Instructions
1. Clone the Repository
```
git clone https://github.com/fauzan-raza/thanx-assignment.git
cd thanx-assignment
```

2. Install Ruby Gems
```
bundle install
```

3. Set Up the Database
```
rails db:setup
```
  This will create the SQLite database, run migrations, and seed initial data.

3. Run the Rails Server
```
rails server
```
API will be available at: http://localhost:3000/api/v1

## 🧪 Run Tests
If you have test coverage set up (e.g., with RSpec), you can run:
```
bundle exec rspec
```

## 🖥️ CLI Usage
The CLI file (`cli.rb`) allows interacting with the API through terminal commands.

### 🔐 Authentication
- Sign Up
```
ruby cli.rb signup email@example.com password123
```

- Sign In

```
ruby cli.rb signin email@example.com password123
```
Saves the access token to .token.

### 🎯 Actions
- Check Points Balance
```
ruby cli.rb points_balance
```

- List Available Rewards
```
ruby cli.rb available_rewards
```

- View Past Redemptions
```
ruby cli.rb reward_redemptions
```

- Redeem a Reward
```
ruby cli.rb redeem_reward REWARD_ID
```
Replace REWARD_ID with the actual ID of the reward (you can get it from available_rewards).

## 📂 Project Structure
```
├── app
│   ├── controllers
│   ├── models
│   └── serializers
├── cli.rb       # Command-line interface for interacting with the API
├── config
├── db
├── Gemfile
├── README.md
└── ...
```

## 📄 License
MIT License