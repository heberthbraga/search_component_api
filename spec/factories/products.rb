FactoryBot.define do
  factory :product do
    trait :reindex do
      after(:create) do |product, _evaluator|
        product.reindex(refresh: true)
      end
    end
  end
end