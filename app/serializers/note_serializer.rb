class NoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :event_id, :created_at
end
