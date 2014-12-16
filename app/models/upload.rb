class Upload < ActiveRecord::Base
  attr_reader :link
  
  default_scope { where(uploaded: true) }
  
  validates :name, presence: true
  validates :size, presence: true, numericality: { less_than_or_equal_to: 100.megabytes }
  validates :mime_type, presence: true
  validates :url, presence: true

  belongs_to :event
  
  def link
    S3_BUCKET.objects["#{self.url}"].url_for(:read).to_s
  end
end
