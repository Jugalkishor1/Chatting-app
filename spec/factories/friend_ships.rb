FactoryBot.define do
  factory :friend_ship do
    user { association :user }
    friend { association :user }
    status { true }
  end
end
