class AddPstToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :pst, :decimal
  end
end
