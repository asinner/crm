class Event < ActiveRecord::Base
  belongs_to :lead
  has_one :timeline, dependent: :destroy
  has_one :estimate, dependent: :destroy
  has_many :uploads, dependent: :destroy
end
