FactoryBot.define do
  factory :job do
    member_id { 1 }
    genre_id { 1 }
    name { Faker::Lorem.characters(number:5) }
  end
end