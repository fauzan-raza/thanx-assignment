# Thanx Assignment
A Ruby on Rails API application with a command-line interface (CLI) for user authentication, points tracking, and reward redemption.

## 🚀 Features
- User sign-up and sign-in (with JWT-based authentication)

- View current points balance

- Browse and redeem rewards

- See past redemptions

- Command-line interface (CLI) to interact with the API

## 🛠️ Requirements
- Ruby: >= 3.0

- Rails: >= 7.0

- Bundler

- SQLite3 (default Rails development DB)

## 🧰 Setup Instructions
1. Clone the Repository (ignore this step if you already have the unzipped project on your machine)
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
bundle exec rails db:setup
```
  This will create the SQLite database, run migrations, and seed initial data.

4. Run the Rails Server
```
bundle exec rails server
```
API will be available at: http://localhost:3000/api/v1

## 🧪 Running Tests
If you have test coverage set up (e.g., with RSpec), you can run:
```
bundle exec rspec
```
Includes unit tests for:

- Model validations

- Business logic for point redemptions

- Enum integrity and transaction constraints

## 📡 API Endpoints

- `GET /api/v1/points_balance` – Get current point balance
- `GET /api/v1/rewards` – List available rewards
- `POST /api/v1/rewards/:id/redeem` – Redeem a reward
- `GET /api/v1/rewards/redemptions` – View redemption history

## 🧪 Seeded user with points for testing CLI
```
Email: test@example.com
Password: password
```
This user is automatically created and seeded with points during `db:setup`.

### 💸 Adding Points to a User
If you'd like to manually give points to a user (e.g., your own account), run:
```
bundle exec rails console
```
Then inside the Rails console:
```
user = User.find_by(email: "you@example.com")
PointTransaction.create!(user: user, amount: 100, reason: :bonus)
```
This adds 100 bonus points to the specified user. You can now redeem rewards using the CLI.

## 🖥️ CLI Usage
The CLI file (`cli.rb`) allows interacting with the API through terminal commands.
After starting the Rails server in one terminal window, open a new terminal, navigate to the project root, and run:

### 🔐 Authentication
- Sign Up
```
ruby cli.rb signup email@example.com password123
```

- Sign In

```
ruby cli.rb signin email@example.com password123
```
This will save the access token to a `.token` file for authenticated requests.

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

## 🧠 What I Did
- Implemented a full backend in Rails with a CLI for interactions

- Attempted to implement a React frontend, but due to time constraints, the frontend was left incomplete

- Models, controllers, and specs for full redemption logic are in place

- Includes redemption logic validations (e.g., cannot redeem more points than you have)

- Used enums and model-level validations to enforce integrity

## 🧱 Data Models & Design Choices
### Models
- User

    - Has many `PointTransaction` records

    - Starts with a configurable points balance

- Reward

    - Represents an item that can be redeemed

    - Contains name, description, and cost_in_points

- PointTransaction

    - Tracks all point changes (bonuses, redemptions)

    - Polymorphic reference for extensibility

    - Enum for reason: :bonus, :reward_redeemed

### Design Assumptions
- Users cannot go into negative point balances

- All redemptions are validated against current point balance

- Reward redemption deducts points and logs a transaction

- All point changes are stored for history and auditability

## 🔧 Additional Features Considered
- A complete React frontend was started in app/javascript, but remains unfinished

- Left hooks in place for eventual React integration (API endpoints and structure)

## 📝 Final Notes
- Built under time constraints — would have preferred to finish the web UI

- CLI approach was taken for quick verifiability of backend behavior

- Easily extendable to a full web UI with existing REST API


## 📄 License
MIT License