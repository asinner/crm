class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :amount, :qty, :role, :estimate_id
end
