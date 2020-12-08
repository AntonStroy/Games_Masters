class CheckoutController < ApplicationController
  # def buy_now
  #   @game = Game.find(params[:id])

  #   if @game.nil?
  #     redirect_to root_path
  #     return
  #   end

  #   # Setting up a Stripe Session for payment.
  #   @session = Stripe::Checkout::Session.create(
  #     payment_method_types: ["card"],
  #     line_items:           [{
  #       name:        @game.name,
  #       description: @game.description,
  #       amount:      (@game.price * 100).to_i,
  #       currency:    "cad",
  #       quantity:    1
  #     }],
  #     success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
  #     cancel_url:           checkout_cancel_url
  #   )

  #   respond_to do |format|
  #     format.js # render create.js.erb
  #   end
  # end

  # def success
  #   @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  #   @payment_inte = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  # end

  def create
    # loop throgh the cart and produce an array of line items
    items = []
    subtotal = 0
    cart.each do |game, qty|
      each_game = {
        name:        game.name,
        description: game.description,
        amount:      (game.price * 100).to_i,
        currency:    "cad",
        quantity:    qty.to_i
      }

      items << each_game
      subtotal += (game.price * 100).to_i * qty.to_i
    end

    if items.blank?
      redirect_to root_path
      return
    end

    taxes = []
    total = subtotal
    if current_customer.province.hst
      hst_tax = (subtotal * current_customer.province.hst).to_i
      taxes << {
        name:     "HST",
        amount:   hst_tax,
        currency: "cad",
        quantity: 1
      }

      total += hst_tax

    else
      if current_customer.province.pst
        pst_tax = (subtotal * current_customer.province.pst).to_i
        taxes << {
          name:     "PST",
          amount:   pst_tax,
          currency: "cad",
          quantity: 1
        }
        total += pst_tax
      end
      if current_customer.province.gst
        gst_tax = (subtotal * current_customer.province.gst).to_i
        taxes << {
          name:     "GST",
          amount:   gst_tax,
          currency: "cad",
          quantity: 1
        }
        total += gst_tax
      end
    end

    # save the order information
    one_order = current_customer.orders.find_or_create_by(
      shipping_address: current_customer.defaultShippingAddress,
      order_amount:     total.to_f / 100,
      gst:              current_customer.province.gst,
      pst:              current_customer.province.pst,
      hst:              current_customer.province.hst,
      order_status:     "new"
    )

    cart.each do |game, qty|
      OrderGame.find_or_create_by(
        game:  game,
        # sku:   game.sku,
        price: game.price,
        qty:   qty,
        order: one_order
      )
      logger.debug(one_order.errors.messages)
    end

    # Setting up a Stripe Session for payment.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items:           items + taxes,
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url
    )

    respond_to do |format|
      format.js # render create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    session[:shopping_cart] = {}
  end

  def cancel; end
end
