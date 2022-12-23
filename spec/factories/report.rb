FactoryBot.define do
  factory :report do
    association :member
    association :comment
    association :reply

    reason { Faker::Lorem.characters(number:5) }
  end
end