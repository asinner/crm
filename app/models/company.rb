class Company < ActiveRecord::Base
  validates :name, presence: true

  has_many :users
  has_many :leads
  has_many :events, through: :leads
  has_many :products
end
