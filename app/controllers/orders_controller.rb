class OrdersController < ApplicationController
  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end
end
