FactoryBot.define do
  factory :reply do
    association :member
    association :comment

    reply { Faker::Lorem.characters(number:7) }
  end
end