class TimelineEvent < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :category, class_name: 'TimelineCategory', foreign_key: 'timeline_category_id'
end
