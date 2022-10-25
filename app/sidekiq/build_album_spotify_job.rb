class BuildAlbumSpotifyJob
  include Sidekiq::Job

  def perform(artist_id)
    artist = Artist.find(artist_id)
    
    albums = RSpotify::Artist.find(artist.spotify.value).albums(limit:50, album_type: 'album,single')
    
    albums.each do |album|
      album_name = album.name.gsub(' - Single', '').gsub(' - EP', '').gsub(/\ (\(|\[)feat\. .*(\)|\])/, '')

      new_album = Album.where('artist_id = ? AND lower(name) = ?', artist.id, album_name.downcase).first_or_create(artist_id: artist.id, name: album_name)

      if album.artists.present? && album.artists.first.name == 'Various Artists'
        album_type = 'compilation'
      else
        album_type = album.album_type
      end

      image = album.images.first['url'] if album.images.present?

      if new_album.release_date.blank? && album&.release_date
        if album.release_date_precision == 'year'
          date = Date.strptime("#{album.release_date}-01-01", '%Y-%m-%d')
        elsif album.release_date_precision == 'month'
          date = Date.strptime("#{album.release_date}-01", '%Y-%m-%d')
        else
          date = album.release_date.to_date
        end
      else
        date = nil
      end

      new_album.spotify_id = album.id
      new_album.spotify_image = image
      new_album.spotify_link = album.external_urls['spotify']
      new_album.album_type = album_type
      new_album.release_date = date if date.present?

      new_album.save
    end
  end
end
