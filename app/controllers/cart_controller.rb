class CartController < ApplicationController
  # # PST /crat
  # # Data sent as form data (params)
  # def create
  #   # Add params[:id] to cart.
  #   id = params[:id].to_i

  #   # unless session[:shopping_cart].include?(id)
  #   session[:shopping_cart] << id
  #   game = Game.find(id)
  #   # session[:stock] ||= game.stock

  #   flash[:notice] = "#{game.name}  Added to cart."
  #   redirect_to game_path(game)
  #   # end
  # end

  # def destroy
  #   # Remove params [:id] from the cart.
  #   id = params[:id].to_i
  #   session[:shopping_cart].delete(id)
  #   game = Game.find(id)
  #   flash[:notice] = "#{game.name} Removed from cart."
  #   redirect_to game_path(game)
  # end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:one_game]["quantity"].to_i
    session[:shopping_cart][id] = quantity
    flash[:notice] = "#{Game.find(id).name} added to cart."

    redirect_to game_path(id)
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:shopping_cart].delete(id.to_s)
    flash[:notice] = "#{Game.find(id).name} removed from cart."
    redirect_to game_path(id)
  end
end
