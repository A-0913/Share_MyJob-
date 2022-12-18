FactoryBot.define do
  factory :job do
    association :member
    association :genre
    name { Faker::Lorem.characters(number:5) }

    after(:create) do |job|
      create_list(:theme_in_job, 1, job: job, theme: create(:theme))
    end
  end
end