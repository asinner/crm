class UploadSerializer < ActiveModel::Serializer
  attributes :id, :name, :mime_type, :size, :link, :event_id
end
