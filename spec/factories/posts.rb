FactoryBot.define do
  factory :post do
    user { association :user }
  end
end
