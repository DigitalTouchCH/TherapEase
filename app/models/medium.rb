class Medium < ApplicationRecord
  belongs_to :therapist
  has_and_belongs_to_many :meetings, join_table: 'media_meetings'
end
