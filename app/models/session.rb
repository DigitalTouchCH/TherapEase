class Session < ApplicationRecord
  belongs_to :package

  validates :start_date_time, presence: true
  validates :end_date_time, presence: true
  validates :max_attendees, numericality: { greater_than_or_equal_to: 1}
end
