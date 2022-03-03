class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
    @favorite = Favorite.new
  end

  def show
    @artist = Artist.find(params[:id])
  end

  def search
    if params[:query].present?
      @artists = Artist.search_by_artist(params[:query])
    else
      # render: "home"
      @artists = Artist.all
    end
  end
end
