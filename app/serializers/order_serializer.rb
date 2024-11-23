class OrderSerializer
  include JSONAPI::Serializer
  attributes :id, :total, :status

  # belongs_to :user
  has_many :items
end
