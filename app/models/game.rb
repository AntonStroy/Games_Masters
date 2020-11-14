class Game < ApplicationRecord
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
end
