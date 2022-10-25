class ArtistsController < ApplicationController
  def index
    @artists = Artist.all

    render json: @artists, include: [:sources]
  end

  def show
    @artist = Artist.find(params[:id])

    render json: @artist, include: [:sources]
  end
end