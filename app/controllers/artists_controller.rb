class ArtistsController < ApplicationController
  def index
    @artists = Artist.all

    render json: @artists, include: [:sources]
  end

  def show
    @artist = Artist.find(params[:id])

    render json: @artist, include: [:sources]
  end

  def create
    @artist = Artist.where('lower(name) = ?', params['artist']['name'].downcase).first_or_create(artist_params)

    if @artist.save
      AddArtistJob.perform_async(@artist.name)

      render json: @artist, include: [:sources], status: :created, location: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

private
  def artist_params
    params.require(:artist).permit(:name)
  end
end