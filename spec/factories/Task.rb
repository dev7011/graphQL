
FactoryBot.define do
  factory :task do
    association :project
    association :assignee, factory: :user # Creates a valid assignee by default

    sequence(:title) { |n| "Task #{n}" }

    description { "Test task" }

    due_date {
      7.days.from_now.to_date
    }



    priority { "high" }

    trait :medium do
      priority { "medium" }
    end

    trait :low do
      priority { "low" }
    end

    status { "todo" }

    trait :in_progress do
      status { "in_progress" }
    end

    trait :done do
      status { "done" }
    end

  end
end