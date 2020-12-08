class OrderGame < ApplicationRecord
  # validates :gst, :pst, :qty, presence: true
  validates :qty, numericality: { only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :order
  belongs_to :game
end
