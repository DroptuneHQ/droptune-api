class CreateMusicVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :music_videos do |t|
      t.string :name
      t.string :image
      t.date :release_date
      t.string :source
      t.string :source_data
      t.belongs_to :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
