class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :amount, :qty, :estimate_id
end
