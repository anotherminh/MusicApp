# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  album_type :string           not null
#  band_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base
  ACCEPTED_ALBUM_TYPES = ["studio", "live"]
  validates :name, :album_type, :band_id, presence: true
  validates :name, uniqueness: { scope: :band_id }
  validates :album_type, inclusion: ACCEPTED_ALBUM_TYPES

  belongs_to :band
  has_many :tracks, dependent: :destroy 
end
