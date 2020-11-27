class HomeController < ApplicationController
  def index
    @games = Game.includes(:developer).includes(:publisher).includes(:genres).page(params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    genre_filter = params[:category]
    time_filter = params[:time]

    @games = Game.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
    if time_filter == "New"
      @games = @games.where(created_at: (Time.now.getlocal - 1.day)..Time.now.getlocal)
    elsif time_filter == "Recently Updated"
      @games = @games.where(updated_at: (Time.now.getlocal - 1.day)..Time.now.getlocal)
    elsif time_filter == "Sale"
      @games = @games.where(price: [nil, "sale"])
    end

    if params[:category].present?
      @games = Game.joins(:genres).where("genres.name"=>genre_filter).where("games.name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
    end
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
end
