class MediaSession < ApplicationRecord
  belongs_to :medium
  belongs_to :session
end
