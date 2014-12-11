
class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :company

  def price=(value)
    self[:price] = value.to_f * 100
  end
  
  def price
    self[:price] / 100.0
  end
end
