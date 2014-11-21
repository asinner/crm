class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :estimate_location, :lead_id
end
