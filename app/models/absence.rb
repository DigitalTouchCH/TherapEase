class Absence < ApplicationRecord
  belongs_to :therapist

  validates :start_date_time, presence: true
  validates :end_date_time, presence: true
end
