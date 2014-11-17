class TimelineCategory < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :timeline
end
