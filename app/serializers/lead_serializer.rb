class LeadSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :phone_number
  
  has_many :events, embed: :ids, include: false
end
