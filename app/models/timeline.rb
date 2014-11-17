class Timeline < ActiveRecord::Base
  belongs_to :event
  has_many :categories, class_name: 'TimelineCategory'
end
