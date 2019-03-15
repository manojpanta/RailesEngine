class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :best_day

  attribute :best_day do |object|
    object.created_at
  end
end
