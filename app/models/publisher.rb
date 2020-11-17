<<<<<<< HEAD
class Publisher < ApplicationRecord
end
=======
class Publisher < ApplicationRecord
  validates :name, presence: true

  has_many :games
end
>>>>>>> active_admin
