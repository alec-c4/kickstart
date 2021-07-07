FactoryBot.define do
  factory :identity do
    user { association :user }
    provider { "google" }
    uid { "123456" }
  end
end
