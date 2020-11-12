class Order < ApplicationRecord
  belongs_to :account
  has_many :order_games
  has_many :games, through: :order_games
end
