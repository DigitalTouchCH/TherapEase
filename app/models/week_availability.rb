class WeekAvailability < ApplicationRecord
  belongs_to :therapist
  has_many :time_blocks

  validates :valid_from, presence: true
  validates :valid_until, presence: true

  # validate :no_overlapping_dates

  private

  # NOT WORKING
  # def no_overlapping_dates
  #   if WeekAvailability.where("id != ? AND ((valid_from <= ? AND valid_until >= ?) OR (valid_from <= ? AND valid_until >= ?) OR (valid_from >= ? AND valid_until <= ?))",
  #                            self.id || 0, valid_from, valid_from, valid_until, valid_until, valid_from, valid_until).exists?
  #     errors.add(:valid_from, "The availability overlaps with another one.")
  #     errors.add(:valid_until, "The availability overlaps with another one.")
  #   elsif WeekAvailability.where("id != ? AND valid_until = ?", self.id || 0, valid_from - 1.day).blank? && WeekAvailability.where("id != ? AND valid_from = ?", self.id || 0, valid_until + 1.day).blank?
  #     errors.add(:base, "There is a gap in availability.")
  #   end
  # end

end
