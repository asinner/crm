class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :date, :lead_id
end
