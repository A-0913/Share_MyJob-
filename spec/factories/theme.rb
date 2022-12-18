FactoryBot.define do
  factory :theme do
    association :member
    name { Faker::Lorem.characters(number:5) }
  end
end