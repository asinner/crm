class Cost < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :product
  
  def amount=(value)
    self[:amount] = value.abs.to_f * 100
  end
  
  def amount
    self[:amount] / 100.0
  end
end
