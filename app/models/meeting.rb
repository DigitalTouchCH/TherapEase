class Meeting < ApplicationRecord
  belongs_to :package

  validates :status, presence: true, inclusion: { in: ["No date set", "Pending", "Confirmed", "Cancelled", "Excused", "Done"] }
end
