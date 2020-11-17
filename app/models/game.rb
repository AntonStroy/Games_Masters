class Game < ApplicationRecord
  validates :name, :description, :release_date, :price, :stock, presence: true
  validates :stock, numericality: { only_integer: true }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :developer
  belongs_to :publisher

  has_many :genre_games
  has_many :genres, through: :genre_games
  accepts_nested_attributes_for :genre_games, allow_destroy: true

  has_many :platform_games
  has_many :platforms, through: :platform_games
  accepts_nested_attributes_for :platform_games, allow_destroy: true

  has_many :order_games
  has_many :orders, through: :order_games

  has_one_attached :cover
end
