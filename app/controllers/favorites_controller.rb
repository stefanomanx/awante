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
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    redirect_to artists_path
    # respond_to do |format|
    #   format.js {render inline: "location.reload();" }
    # end
  end
end
