
FactoryBot.define do
  factory :project do
    sequence(:name) do |n|
      "Project #{n}"
    end

    description { "Test project" }

    association :owner, factory: :user
  end
end


