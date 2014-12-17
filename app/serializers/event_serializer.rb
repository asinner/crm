class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date
  
  has_one :estimate
  has_one :address
  has_one :lead
  has_one :timeline
end
