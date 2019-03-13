class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_revenue

  attribute :total_revenue do |object|
    Money.new(object.revenue, "USD").to_s
  end
end
