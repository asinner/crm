class TimelineCategory < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :timeline
  has_many :events, class_name: 'TimelineEvent'
end
