class Therapist < ApplicationRecord
  has_one_attached :photo
  has_one :user, dependent: :destroy

  validates :location_name, presence: true
  validates :location_address, presence: true
end
