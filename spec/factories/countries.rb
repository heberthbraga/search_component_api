FactoryBot.define do
  factory :country do
    factory :us_country, class: Country do
      code { 'US' }
      name { 'United States' }
    end
    factory :ca_country, class: Country do
      code { 'CA' }
      name { 'Canada' }
    end
  end
end