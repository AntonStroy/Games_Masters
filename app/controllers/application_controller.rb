class ApplicationController < ActionController::Base
  helper_method :categories_genres
  def categories_genres
    @genres = Genre.all
  end

  helper_method :cms_pages
  def cms_pages
    Page.all
  end
end
