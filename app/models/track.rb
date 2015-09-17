# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  track_type :string           not null
#  lyrics     :text             not null
#  album_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  ACCEPTED_TRACK_TYPES = ["regular", "studio"]
  validates :name, :track_type, :lyrics, :album_id, presence: true
  validates :name, uniqueness: { scope: :album_id }
  validates :track_type, inclusion: ACCEPTED_TRACK_TYPES

  belongs_to :album
  has_one :band, through: :album, source: :band
end
