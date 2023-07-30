FactoryBot.define do
  factory :idea_response do
    attempt { nil }
    idea { nil }
    value { "MyString" }
    comment { "MyText" }
  end
end
