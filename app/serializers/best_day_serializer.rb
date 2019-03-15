class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :date

  attribute :date do |object|
    object.created_at.to_date.to_s
  end
end
