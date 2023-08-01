FactoryBot.define do
  factory :attempt do
    association :treasure_hunt
    user { nil }
  end
end
