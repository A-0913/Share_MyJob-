FactoryBot.define do
  factory :theme_in_job do
    association :job
    association :theme
  end
end