class Artist < ApplicationRecord
  has_many :sources

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
