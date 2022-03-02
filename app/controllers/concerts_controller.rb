class ConcertsController < ApplicationController
  def index
    @concerts = Concert.all.order(date: :asc)
  end

  def show
    @concert = Concert.find(params[:id])
  end
end
