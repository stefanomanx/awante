class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.new(params[:id])
    @artist = Artist.find(params[:artist_id])
    @favorite.artist = @artist
    @favorite.user = current_user
    @favorite.save
  end
end
