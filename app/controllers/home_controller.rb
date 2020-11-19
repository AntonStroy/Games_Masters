class HomeController < ApplicationController
  def index
    @games = Game.includes(:developer).includes(:publisher).includes(:genres).page(params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @games = Game.where("name LIKE ?", wildcard_search)
  end

  def sort_a_z
    @games = Game.order(:name) # ASC
  end

  def sort_z_a
    @games = Game.order(name: :desc) # DESC
  end

  def sort_low_high
    @games = Game.order(:price) # ASC
  end

  def sort_high_low
    @games = Game.order(price: :desc) # DESC
  end

  def download_free
    @games = Game.where(price: [nil, 0.0])
  end
end
