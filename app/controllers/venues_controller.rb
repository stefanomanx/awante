class VenuesController < ApplicationController

  def index
    @venues = Venue.all.order(name: :asc)
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
    @concerts = Concert.all.order(date: :asc)
    @marker = @venue.geocode
  end
end
