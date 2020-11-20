class ApplicationController < ActionController::Base
  helper_method :categories_genres

  def categories_genres
    @genres = Genre.all
  end
end