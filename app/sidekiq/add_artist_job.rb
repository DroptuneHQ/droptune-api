class AddArtistJob
  include Sidekiq::Job

  def perform(artist_name)
    artist = Artist.where('lower(name) = ?', artist_name.downcase).first_or_create(name: artist_name)

    # Spotify
    spotify_artist = RSpotify::Artist.search(artist.name).first
    if spotify_artist.present?
      artist.name = spotify_artist.name
      artist.image = spotify_artist.images.first['url'] if spotify_artist.images.present?

      Source.find_or_create_by(artist: artist, name: 'spotify', value: spotify_artist.id)
    end

    artist.save
  end
end
