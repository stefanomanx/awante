class ConcertsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @concerts = Concert.all.order(date: :asc)
  end

  def show
    @concert = Concert.find(params[:id])
  end
end
