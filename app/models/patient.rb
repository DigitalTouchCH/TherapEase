class Patient < ApplicationRecord
  has_one_attached :photo
  belongs_to :user, dependent: :destroy

  validates :date_of_birth, presence: true
  validates :tel_1, presence: true
end
