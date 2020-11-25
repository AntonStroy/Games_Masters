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

  private

  def initialize_session
    # This will be where we initialize our shopping cart.
    session[:shopping_cart] ||= [] # the shopping cart will be an array of product ids.
  end

  def cart
    # Return a collection of Product objects based on the product ids in the shopping cart.
    Product.find(session[:shopping_cart])
  end
end
