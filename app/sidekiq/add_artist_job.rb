class AddArtistJob
  include Sidekiq::Job

  def perform(artist_name)
    artist = Artist.where('lower(name) = ?', artist_name.downcase).first_or_create(name: artist_name)
    artist.save

    # Spotify
    SourceSpotifyJob.perform_async(artist.id)

    # Apple Music
    SourceAppleMusicJob.perform_async(artist.id)

    # MusicBrainz
    SourceMusicBrainzJob.perform_async(artist.id)
  end
end
