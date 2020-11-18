class GamesController < ApplicationController
  def index
    @games = Game.includes(:developer).order("name").includes(:publisher).order("name").includes(:genres).page(params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    @games = Game.where("name LIKE ?", wildcard_search)
  end
end
