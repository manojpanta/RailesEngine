class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attribute :id do |object|
    object.id.to_i
  end
end
