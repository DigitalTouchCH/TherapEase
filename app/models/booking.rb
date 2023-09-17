class Booking < ApplicationRecord
  belongs_to :patient
  belongs_to :meeting

  validates :status, presence: true, inclusion: { in: ["Pending", "Confirmed", "Cancelled", "excused", "done"] }
end
