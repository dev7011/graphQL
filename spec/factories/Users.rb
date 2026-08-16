FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8, max_length: 16, mix_case: true, special_characters: true) }

    role { :admin }

    trait :user do
      role { :user }
    end

    trait :custom do
      role { :custom }
    end
  end
end
