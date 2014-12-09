class Event < ActiveRecord::Base
  belongs_to :lead
  has_one :timeline
  has_one :estimate
  has_many :uploads
end
