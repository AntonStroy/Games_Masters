class PageController < ApplicationController
  def permalink
    @page = Page.find_by(permalink: params[:permalink])
  end
end
