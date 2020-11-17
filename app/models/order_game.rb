<<<<<<< HEAD
class OrderGame < ApplicationRecord
  belongs_to :order
  belongs_to :game
end
=======
class OrderGame < ApplicationRecord
  validates :gst, :pst, :release_date, :price, :qty, presence: true
  validates :qty, numericality: { only_integer: true }
  valdiates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :order
  belongs_to :game
end
>>>>>>> active_admin
