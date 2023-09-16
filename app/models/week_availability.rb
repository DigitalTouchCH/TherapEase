class WeekAvailability < ApplicationRecord
  belongs_to :therapist
  has_many :time_blocks, dependent: :destroy

  validates :valid_from, presence: true
  validates :valid_until, presence: true

  validate :no_overlapping_dates

  private

  def no_overlapping_dates
    return unless valid_from_changed? || valid_until_changed?

    overlapping_availabilities = self.therapist.week_availabilities.where.not(id: self.id)
                                                    .where("(valid_from <= ? AND valid_until >= ?) OR
                                                            (valid_from <= ? AND valid_until >= ?) OR
                                                            (valid_from >= ? AND valid_until <= ?)",
                                                            valid_from, valid_from, valid_until, valid_until, valid_from, valid_until)

    if overlapping_availabilities.exists?
        errors.add(:valid_from, "The availability overlaps with another one.")
        errors.add(:valid_until, "The availability overlaps with another one.")
    end
  end


end
