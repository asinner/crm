class Cost < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :product
  
  def amount=(value)
    self[:amount] = value.to_f.abs * 100
  end
  
  def amount
    self[:amount] / 100.0
  end
end
