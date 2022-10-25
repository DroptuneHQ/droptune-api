class BuildYoutubeJob
  include Sidekiq::Job

  def perform(artist_id)
    artist = Artist.find(artist_id)

    if artist.youtube.present?
      channel = Yt::Channel.new url: artist.youtube.value

      channel.videos.each do |video|
        music_video = MusicVideo.find_or_create_by(
          artist: artist, 
          name: video.title, 
          source: 'youtube', 
          source_data: video.id,
          release_date: Date.parse(video.snippet.data['publishedAt']),
          image: video.snippet.data['thumbnails']['high']['url']
        )
        music_video.save
      end
    end
  end
end
