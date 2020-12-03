class AddStripeIntentIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :stripe_intent_id, :integer
  end
end
