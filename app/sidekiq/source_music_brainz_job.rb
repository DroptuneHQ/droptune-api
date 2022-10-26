class SourceMusicBrainzJob
  include Sidekiq::Job

  def perform(artist_id)
    musicbrainz_days = 90 # Cache
    
    artist = Artist.find(artist_id)
    musicbrainz_artist = MusicBrainz::Artist.find_by_name(artist.name)

    if musicbrainz_artist.present?
      # Source and then set updated_at
      source = Source.find_or_create_by(artist: artist, name: 'musicbrainz', value: musicbrainz_artist.id)

      if source.updated_at = source.created_at or source.updated_at < musicbrainz_days.days.ago
        urls = musicbrainz_artist.urls

        if urls[:youtube].present?
          external_youtube = Array.wrap(urls[:youtube]).first

          Source.find_or_create_by(artist: artist, name: 'youtube', value: external_youtube)

          BuildYoutubeJob.perform_async(artist.id)
        end

        if urls[:social_network].present?
          # Twitter
          external_twitter = Array.wrap(urls[:social_network]).select{|key| key.include?("twitter")}&.first
          if external_twitter.present?
            twitter_handle = external_twitter.match(/((https?:\/\/)?(www\.)?twitter\.com\/)?(@|#!\/)?([A-Za-z0-9_]{1,15})(\/([-a-z]{1,20}))?/)[5]
            
            Source.find_or_create_by(artist: artist, name: 'twitter', value: twitter_handle)
            
            SourceTwitterJob.perform_async(artist.id)
          end

          # Instagram
          external_instagram = Array.wrap(urls[:social_network]).select{|key| key.include?("instagram")}&.first
          if external_instagram.present?
            instagram_handle = external_instagram.match(/((https?:\/\/)?(www\.)?instagram\.com\/)?(@|#!\/)?([A-Za-z0-9_]{1,15})(\/([-a-z]{1,20}))?/)[5]
            Source.find_or_create_by(artist: artist, name: 'instagram', value: instagram_handle)
          end

          # Facebook
          external_facebook = Array.wrap(urls[:social_network]).select{|key| key.include?("facebook")}&.first
          if external_facebook.present?
            facebook_handle = external_facebook.match(/((https?:\/\/)?(www\.)?facebook\.com\/)?(@|#!\/)?([A-Za-z0-9_]{1,15})(\/([-a-z]{1,20}))?/)[5]
            Source.find_or_create_by(artist: artist, name: 'facebook', value: facebook_handle)
          end

          source.touch
        end
      end
    end

  end
end
