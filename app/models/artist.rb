class Artist < ApplicationRecord
  has_many :sources

  validates :name, presence: true

  def spotify
    sources.where('sources.name = ?', 'spotify').first
  end
end
