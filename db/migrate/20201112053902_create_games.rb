class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :sku
      t.string :name
      t.text :description
      t.date :release_date
      t.string :rating
      t.decimal :price
      t.integer :stock
      t.string :link
      t.string :cover
      t.references :developer, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
