class ArtistsController < ApplicationController

  def index
    @artists = Artist.all
    @favorite = Favorite.new
  end

  def show
    @artist = Artist.find(params[:id])
  end
end
