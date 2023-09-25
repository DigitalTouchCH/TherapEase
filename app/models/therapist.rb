class Therapist < ApplicationRecord
  has_one_attached :photo
  belongs_to :user, dependent: :destroy
  has_and_belongs_to_many :services
  has_many :packages
  has_many :meetings, through: :packages
  has_many :media
  has_many :absences, dependent: :destroy
  has_many :week_availabilities


  validates :location_name, presence: true
  validates :location_address, presence: true
end
