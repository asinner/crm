class Estimate < ActiveRecord::Base
  belongs_to :event

  has_many :items, class_name: 'LineItem'
end
