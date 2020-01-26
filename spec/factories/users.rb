FactoryBot.define do
  factory :user do
    factory :api_user, class: User do
      name        { Faker::Name.first_name }
      email       { Faker::Internet.email }
      password    { Faker::Internet.password(min_length: 8) }
    end
  end
end