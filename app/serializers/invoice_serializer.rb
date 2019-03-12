class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :customer_id, :merchant_id, :status
  attribute :id do |object|
    object.id.to_i
  end
end
