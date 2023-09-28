class Package < ApplicationRecord
  belongs_to :service
  belongs_to :therapist
  belongs_to :patient
  has_many :meetings, dependent: :destroy

  validates :num_of_session, presence: true, numericality: { greater_than_or_equal_to: 1, less_than: 11 }
  validates :package_type, presence: true, inclusion: { in: ["Individual", "Group"] }

  def media_list
    media = []
    meetings = Meeting.where(package_id: id)
    meetings.each do |meeting|
      media_for_meeting = Medium.joins(:media_meetings).where(media_meetings: { meeting_id: meeting.id })
      media_for_meeting.each { |medium| media << medium } unless media_for_meeting.empty?
      media.uniq!
    end
    media
  end
end
