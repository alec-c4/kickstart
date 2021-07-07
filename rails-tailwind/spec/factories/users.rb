FactoryBot.define do
  factory :user, aliases: %i[author commenter] do
    first_name { "Steve" }
    last_name { "Jobs" }
    email { "user@example.com" }
    password { "user@example.com" }
    confirmed_at { Time.zone.now }

    factory :customer do
      email { "customer@example.com" }
    end

    factory :admin do
      email { "admin@example.com" }
    end
  end
end
