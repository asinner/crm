class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0}

  belongs_to :company

  def price=(value)
    value *= 100
    self[:price] = value
  end
end
