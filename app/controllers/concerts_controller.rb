require 'date'

class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!

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
    @date = DateTime.parse(@concert.date)
    @fecha = @date.strftime('%d/%m/%Y %H:%M').split(' ')[0]
    @hora = @date.strftime('%d/%m/%Y %H:%M').split(' ')[1]
    @venue_id = @concert.venue_id
    @venue = Venue.find(@venue_id)
  end
end
