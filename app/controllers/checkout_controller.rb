class CheckoutController < ApplicationController
  def create
    @game = Game.find(params[:id])

    if @game.nil?
      redirect_to root_path
      return
    end

    # Setting up a Stripe Session for payment.
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items:           [{
        name:        @game.name,
        description: @game.description,
        amount:      (@game.price * 100).to_i,
        currency:    "cad",
        quantity:    1
      }],
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url
    )

    respond_to do |format|
      format.js # render create.js.erb
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_inte = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel; end
end
