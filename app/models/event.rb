class Event < ActiveRecord::Base
  validates :date, presence: true
  
  belongs_to :lead
  
  has_one :timeline, dependent: :destroy
  has_one :estimate, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :uploads, dependent: :destroy
  
  accepts_nested_attributes_for :address
end
