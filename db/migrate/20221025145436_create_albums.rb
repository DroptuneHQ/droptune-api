class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.belongs_to :artist, null: false, foreign_key: true
      t.string :name
      t.date :release_date
      t.string :album_type
      t.text :spotify_id
      t.text :spotify_image
      t.text :spotify_link
      t.bigint :applemusic_id
      t.text :applemusic_image
      t.text :applemusic_link

      t.timestamps
    end
  end
end
