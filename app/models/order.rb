class Order < ApplicationRecord
  validates :order_date, :order_amount, :shipping_address, :shipping_city, :shipping_province, :shipping_postal, presence: true
  # validates :stock, numericality: { only_integer: true }
  valdiates :order_amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :account
  has_many :order_games
  has_many :games, through: :order_games
end
