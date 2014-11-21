class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true

  belongs_to :company

  def price=(value)
    value *= 100
    self[:price] = value
  end
end
