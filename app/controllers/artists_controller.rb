class ArtistsController < ApplicationController
  skip_before_action :authenticate_user!

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
    @concerts = Concert.all.order(date: :asc)
    @events = []
    @concerts.each do |concert|
      if concert.artist_id == @artist.id
        @events << concert
      end
    end
  end
end
