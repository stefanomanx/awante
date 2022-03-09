class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.new(params[:id])
    @artist = Artist.find(params[:artist_id])
    @favorite.artist = @artist
    @favorite.user = current_user
    @favorite.save
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def destroy
    @artist = Artist.find(params[:artist_id])
    @favorite.artist = @artist
    @favorite.user = current_user
    @favorite.destroy
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end
end
