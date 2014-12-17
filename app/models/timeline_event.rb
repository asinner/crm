class TimelineEvent < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :category, class_name: 'TimelineCategory', foreign_key: 'timeline_category_id'
end
