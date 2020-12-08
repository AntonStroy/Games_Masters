class Order < ApplicationRecord
  validates :order_amount, :shipping_address, presence: true
  # validates :stock, numericality: { only_integer: true }
  validates :order_amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :customer
  has_many :order_games
  has_many :games, through: :order_games
end
