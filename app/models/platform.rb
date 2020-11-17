class Platform < ApplicationRecord
  validates :name, presence: true

  has_many :platform_games
  has_many :games, through: :platform_games
end
