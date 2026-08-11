30.times do
  Project.create(
    name: Faker::App.name,
    description: Faker::Lorem.paragraph,
    status: rand(0..2),
    owner_id: rand(1..10)
  )
end

10.times do
  next
  User.create(
    last_name: Faker::Name.last_name,
    username: Faker::Internet.username(specifier: 5..8),
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    role: rand(0..2)
  )
end