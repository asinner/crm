class Lead < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  belongs_to :company
  has_many :events, dependent: :destroy
  
  accepts_nested_attributes_for :events
end
