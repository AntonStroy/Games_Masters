class CreateOrderGames < ActiveRecord::Migration[6.0]
  def change
    create_table :order_games do |t|
      t.decimal :price
      t.integer :sku
      t.integer :qty
      t.float :pst
      t.float :gst
      t.references :order, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
