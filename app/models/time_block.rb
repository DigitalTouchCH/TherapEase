class TimeBlock < ApplicationRecord
  belongs_to :week_availability

  validates :week_day, presence: true, inclusion: { in: "monday".."sunday" }
  validates :start_time, presence: true
  validates :end_time, presence: true, time: { after_or_equal_to: :start_time }
end
