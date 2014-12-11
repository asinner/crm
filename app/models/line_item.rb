class LineItem < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :estimate
  
  def amount=(value)
    self[:amount] = value.to_f * 100
  end
  
  def amount
    self[:amount] / 100.0
  end
end
