class Service < ApplicationRecord
  has_and_belongs_to_many :therapists
  has_many :packages
end
