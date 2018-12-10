FactoryBot.define do
  factory :apikey do
    user_id 1
    host 0
    sequence :uid
    key ENV["GITHUB_KEY"]
    association :user, factory: :user
  end
end
