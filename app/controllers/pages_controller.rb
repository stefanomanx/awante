class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if params[:query].present?
      @artists = Artist.search_by_artist(params[:query])
    else
      # render: "home"
      @artists = Artist.all
    end
  end
end
