class BuildAlbumAppleMusicJob
  include Sidekiq::Job

  def perform(artist_id)
    artist = Artist.find(artist_id)
    
    albums = AppleMusic::Artist.get_relationship(artist.apple_music.value, :albums)

    albums.each do |album|
      album_name = album.name.gsub(' - Single', '').gsub(' - EP', '').gsub(/\ (\(|\[)feat\. .*(\)|\])/, '')

      new_album = Album.where('artist_id = ? AND lower(name) = ?', artist.id, album_name.downcase).first_or_create(artist_id: artist.id, name: album_name)

      if album.is_single == true
        album_type = 'single'
      else
        album_type = 'album'
      end

      new_album.update applemusic_id: album.id, applemusic_image: album.artwork.url, applemusic_link: album.url, album_type: album_type, release_date: album.release_date
    end
  end
end
