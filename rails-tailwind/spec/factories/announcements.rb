FactoryBot.define do
  factory :announcement, class: "Announcement" do
    published_at { "2021-05-10 21:36:55" }
    announcement_type { "MyString" }
    name { "MyString" }
    description { "MyText" }
  end
end
