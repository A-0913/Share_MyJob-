FactoryBot.define do
  factory :comment do
    association :member
    association :job
    theme { job.themes.first }

    comment { Faker::Lorem.characters(number:5) }
  end
end