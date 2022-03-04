class ArtistsController < ApplicationController

  def index
    if params[:query].present?
      @artists = Artist.all.order(name: :asc).search_by_artist(params[:query])
    else
      # render: "home"
      @artists = Artist.all.order(name: :asc)
    end
    @favorite = Favorite.new
  end

  def show
    @artist = Artist.find(params[:id])
  end
end
