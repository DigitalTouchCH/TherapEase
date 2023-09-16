class TimeBlock < ApplicationRecord
  belongs_to :week_availability

  validates :week_day, presence: true, inclusion: { in: %w[monday tuesday wednesday thursday friday saturday sunday] }
  validates :start_time, presence: true
  validates :end_time, presence: true
end
