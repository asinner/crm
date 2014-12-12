class CostSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :name, :description, :amount, :qty, :automatic
end
