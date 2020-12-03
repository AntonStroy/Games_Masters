class ApplicationController < ActionController::Base
  helper_method :categories_genres
  def categories_genres
    @genres = Genre.all
  end

  helper_method :cms_pages
  def cms_pages
    Page.all
  end

  before_action :initialize_session
  helper_method :cart

  before_action :add_permitted_parameters, if: :devise_controller?

  protected

  def add_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[defaultShippingAddress province_id])
  end

  private

  def initialize_session
    # This will be where we initialize our shopping cart.
    session[:shopping_cart] ||= {} # the shopping cart will be an array of product ids.
  end

  # def cart
  #   # Return a collection of Product objects based on the product ids in the shopping cart.
  #   Game.find(session[:shopping_cart])
  # end

  def cart
    session[:shopping_cart].transform_keys { |game_id| Game.find(game_id) }
  end
end
