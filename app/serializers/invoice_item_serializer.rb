class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  attribute :unit_price do |object|
    Money.new(object.unit_price, "USD").to_s
  end
end
