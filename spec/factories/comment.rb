FactoryBot.define do
  factory :comment do
    association :member
    association :job
    association :theme
    comment { Faker::Lorem.characters(number:5) }
  end
end