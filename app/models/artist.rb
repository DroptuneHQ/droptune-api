class Artist < ApplicationRecord
  has_many :sources
  has_many :albums
  has_many :music_videos

  validates :name, presence: true

  def spotify
    sources.where('sources.name = ?', 'spotify').first
  end
  
  def youtube
    sources.where('sources.name = ?', 'youtube').first
  end

  def apple_music
    sources.where('sources.name = ?', 'apple_music').first
  end
end
