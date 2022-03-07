class ConcertsController < ApplicationController
  def index
    @concerts = Concert.all.order(date: :asc)
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
    @concert = Concert.find(params[:id])
  end
end
