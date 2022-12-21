FactoryBot.define do
  factory :job do
    association :member
    association :genre
    name { Faker::Lorem.characters(number:5) }

    after(:create) do |job|
      theme = create(:theme)
      create_list(:theme_in_job, 1, job_id: job.id, theme_id: theme.id)
    end
  end
end