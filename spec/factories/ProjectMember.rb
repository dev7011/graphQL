# spec/factories/project_members.rb

FactoryBot.define do
  factory :project_member do
    association :project
    association :user

    role { "manager" }

    trait :developer do
      role { "developer" }
    end

    trait :viewer do
      role { "viewer" }
    end
  end
end
