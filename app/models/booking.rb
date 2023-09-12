class Booking < ApplicationRecord
  belongs_to :patient
  belongs_to :session

  validates :status, presence: true, inclusion: { in: ["Pending", "Confirmed", "Cancelled", "excused", "done"] }
end
