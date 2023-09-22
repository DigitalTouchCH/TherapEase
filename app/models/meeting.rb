class Meeting < ApplicationRecord
  belongs_to :package
  has_many :bookings, dependent: :destroy

  validates :status, presence: true, inclusion: { in: ["No date set", "Pending", "Confirmed", "Cancelled", "Excused", "Done"] }
end
