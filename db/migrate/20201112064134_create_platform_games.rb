class CreatePlatformGames < ActiveRecord::Migration[6.0]
  def change
    create_table :platform_games do |t|
      t.references :platform, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
