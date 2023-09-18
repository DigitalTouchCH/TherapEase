class Absence < ApplicationRecord
  belongs_to :therapist

  validates :start_time, presence: true
  validates :end_time, presence: true
end
