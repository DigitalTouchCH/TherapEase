class Package < ApplicationRecord
  belongs_to :service
  belongs_to :therapist
  belongs_to :patient
  has_many :meetings, dependent: :destroy

  validates :num_of_session, presence: true, numericality: { greater_than: 1, less_than: 10 }
  validates :package_type, presence: true, inclusion: { in: ["Individual", "Group"] }
end
