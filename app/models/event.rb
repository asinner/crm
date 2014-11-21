class Event < ActiveRecord::Base
  validates :estimate_location, presence: true

  belongs_to :lead
  has_one :timeline
end
