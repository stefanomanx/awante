class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @concerts = Concert.all
    @artists = Artist.all
  end
end
