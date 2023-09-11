class WeekAvailability < ApplicationRecord
  belongs_to :therapist
  has_many :time_blocks

  validates :valid_from, presence: true
  validates :valid_until, presence: true
end
