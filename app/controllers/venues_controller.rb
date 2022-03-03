class VenuesController < ApplicationController

  def index
    @venues = Venue.all
    @markers = @venues.geocoded.map do |venue|
      {
        lat: venue.latitude,
        lng: venue.longitude,
        info_window: render_to_string(partial: "info_window", locals: { venue: venue })
      }
    end
  end
  def show
    @venue = Venue.find(params[:id])
    @artists = Artist.all
    @concerts = Concert.all

    @events = []
    @concerts.each do |concert|
      if concert.venue_id == @venue.id
        @events << concert
      end
    end
  end
end
