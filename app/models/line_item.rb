class LineItem < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :estimate
end
