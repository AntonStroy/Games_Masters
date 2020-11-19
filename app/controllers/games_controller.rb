class GamesController < ApplicationController
  def index
    @games = Game.includes(:developer).includes(:publisher).includes(:genres).page(params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end
end
