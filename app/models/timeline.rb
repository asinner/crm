class Timeline < ActiveRecord::Base
  belongs_to :event
  has_many :events, class_name: 'TimelineEvent'
end
