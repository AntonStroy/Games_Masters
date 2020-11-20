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

  def sort_az
    @games = Game.order(:name).includes(:genres).page(params[:page]) # ASC
  end

  def sort_za
    @games = Game.order(name: :desc).includes(:genres).page(params[:page]) # DESC
  end

  def sort_low_high
    @games = Game.order(:price).includes(:genres).page(params[:page]) # ASC
  end

  def sort_high_low
    @games = Game.order(price: :desc).includes(:genres).page(params[:page]) # DESC
  end

  def sale_search
    @games = Game.where(price: [nil, "sale"])
  end
end
