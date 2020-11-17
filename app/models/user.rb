class User < ApplicationRecord
  validates :login, :password, presence: true

  has_one :account
end