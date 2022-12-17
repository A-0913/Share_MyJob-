FactoryBot.define do
  factory :member do
    last_name { "test.l" }
    first_name { "test.f" }
    nickname { "testman" }
    belong { "転職を検討中" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testmember" }
    password_confirmation { "testmember" }
    introduction { "testtesttest" }
  end
end