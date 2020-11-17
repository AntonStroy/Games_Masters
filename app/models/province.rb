<<<<<<< HEAD
class Province < ApplicationRecord
end
=======
class Province < ApplicationRecord
  validates :name, :pst, presence: true

  has_many :accounts
end
>>>>>>> active_admin
