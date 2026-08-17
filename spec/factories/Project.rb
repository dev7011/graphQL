
FactoryBot.define do
  factory :project do
    sequence(:name) do |n|
      "Project #{n}"
    end

    status { "active" }

    description { "Test project" }

    association :owner, factory: :user
  end
end


