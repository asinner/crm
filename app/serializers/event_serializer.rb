class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :lead_id
  
  has_one :estimate
end
