<<<<<<< HEAD
class Developer < ApplicationRecord
end
=======
class Developer < ApplicationRecord
  validates :name, presence: true

  has_many :games
end
>>>>>>> active_admin
