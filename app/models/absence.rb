class Absence < ApplicationRecord
  belongs_to :therapist

  validates :start_date_time, presence: true
  validates :end_date_time, presence: true, date: { after_or_equal_to: :start_date_time }
end
