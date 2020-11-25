class CartController < ApplicationController
  # PST /crat
  # Data sent as form data (params)
  def create
    # Add params[:id] to cart.
    id = params[:id].to_i

    unless session[:shopping_cart].include?(id)
      session[:shopping_cart] << id
      game = Game.find(id)
      flash[:notice] = "#{game.name}  Added to cart."
      redirect_to game_path(game)
    end
  end

  def destroy
    # Remove params [:id] from the cart.
    id = params[:id].to_i
    session[:shopping_cart].delete(id)
    game = Game.find(id)
    flash[:notice] = "#{game.name} Removed from cart."
    redirect_to game_path(game)
  end
end
