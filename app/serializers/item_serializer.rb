class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :unit_price, :merchant_id

  attribute :unit_price do |object|
    Money.new(object.unit_price, "USD").to_s
  end
end
