class Artist < ApplicationRecord
  has_many :sources

  validates :name, presence: true
end
