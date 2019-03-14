class RevenueForSingleMerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue
  attribute :revenue do |object|
    Money.new(object.revenue, "USD").to_s
  end
end
