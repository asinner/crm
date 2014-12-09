class LineItem < ActiveRecord::Base
  validates :name, presence: true
end
