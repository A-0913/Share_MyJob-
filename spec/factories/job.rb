FactoryBot.define do
  factory :job do
    association :member
    association :genre
    name { Faker::Lorem.characters(number:5) }
  end
end