class NoteSerializer < ActiveModel::Serializer
  attributes :id, :body, :lead_id
end
