class SourceSpotifyJob
  include Sidekiq::Job

  def perform(artist_id)
    artist = Artist.find(artist_id)
    
    spotify_artist = RSpotify::Artist.search(artist.name).first

    if spotify_artist.present?
      artist.name = spotify_artist.name
      artist.image = spotify_artist.images.first['url'] if spotify_artist.images.present?
      artist.save

      Source.find_or_create_by(artist: artist, name: 'spotify', value: spotify_artist.id)

      BuildAlbumSpotifyJob.perform_async(artist.id)
    end
  end
end
