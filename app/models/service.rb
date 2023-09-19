class Service < ApplicationRecord
  has_and_belongs_to_many :therapists
  has_many :packages
  has_one_attached :photo
end
