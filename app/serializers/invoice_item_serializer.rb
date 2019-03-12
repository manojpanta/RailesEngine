class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :item_id, :invoice_id, :quantity, :unit_price

  attribute :unit_price do |object|
    Money.new(object.unit_price, "USD").to_s
  end

end
