30.times do
  Project.create(
    name: Faker::App.name,
    description: Faker::Lorem.paragraph,
    status: rand(0..2),
    owner_id: rand(1..10)
  )
end

10.times do
  User.create(
    last_name: Faker::Name.last_name,
    username: Faker::Internet.username(specifier: 5..8),
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    role: rand(0..2)
  )
end

project = Project.find(57)
user = User.find(11)

100.times do |i|
  project.tasks.create!(
    title: Faker::Lorem.sentence(word_count: 10),
    description: Faker::Lorem.paragraph,
    status: %w[todo in_progress done].sample,
    priority: %w[low medium high].sample,
    due_date: Date.current + rand(1..30).days,
    assignee: user
  )
end