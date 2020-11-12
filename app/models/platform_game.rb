class PlatformGame < ApplicationRecord
  belongs_to :platform
  belongs_to :game
end
