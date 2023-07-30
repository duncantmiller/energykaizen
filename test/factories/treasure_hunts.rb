FactoryBot.define do
  factory :treasure_hunt do
    association :team
    name { "MyString" }
    starts_at { "2023-07-29 23:07:33" }
    ends_at { "2023-07-29 23:07:33" }
    call_to_action { "MyText" }
    incentive { "MyText" }
    allow_image { false }
    token { "MyString" }
  end
end
