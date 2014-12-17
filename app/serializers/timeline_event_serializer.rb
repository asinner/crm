class TimelineEventSerializer < ActiveModel::Serializer
  attributes :id, :body, :start_time, :end_time
end
