class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.timestamp :order_date
      t.decimal :order_amount
      t.string :order_status
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_province
      t.string :shipping_postal
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
