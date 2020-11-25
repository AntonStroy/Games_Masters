# frozen_string_literal: true

# step one after instaling gem for stripe
Rails.configuration.stripe = {
  publishable_key: ENV["PUBLISHABLE_KEY"],
  secret_key:      ENV["SECRET_KEY"]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
