class Event < ActiveRecord::Base
  belongs_to :lead
  has_one :timeline, dependent: :delete
  has_one :estimate, dependent: :delete
  has_many :uploads, dependent: :delete_all
end
