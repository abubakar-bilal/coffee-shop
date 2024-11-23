class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :price, :tax_rate
end
