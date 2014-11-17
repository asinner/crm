class Event < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :company
  has_one :timeline
end
