FactoryBot.define do
  factory :job do
    genre { "サービス" }
    name { Faker::Lorem.characters(number:5) }
  end
end