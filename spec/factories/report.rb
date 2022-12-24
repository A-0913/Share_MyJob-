FactoryBot.define do
  factory :report do
    association :member
    association :comment
    association :reply

    reason { '法律違反である（プライバシー侵害、企業情報漏洩、名誉棄損等）' }
  end
end