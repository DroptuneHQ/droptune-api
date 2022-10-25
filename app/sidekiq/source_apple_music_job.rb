class SourceAppleMusicJob
  include Sidekiq::Job

  def perform(artist_id)
    artist = Artist.find(artist_id)
    apple_music_artist = AppleMusic::Artist.search(artist.name).first
  
    if apple_music_artist.present?
      Source.find_or_create_by(artist: artist, name: 'apple_music', value: apple_music_artist.id)

      BuildAlbumAppleMusicJob.perform_async(artist.id)
    end
  end
end
