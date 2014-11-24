class Upload < ActiveRecord::Base
  validates :name, presence: true
  validates :size, presence: true, numericality: { less_than_or_equal_to: 1.gigabyte }
  validates :mime_type, presence: true
  validates :path, presence: true

  belongs_to :event
end
