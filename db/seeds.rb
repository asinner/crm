# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.find_by(email: 'andrew@example.com')


20.times do
  u.company.leads.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone
  )
end

Lead.all.each do |l|
  3.times do
    l.events.create!(
      name: '',
      date: rand(30..180).days.from_now
    )
  end
  
  10.times do
    l.notes.create(
      body: Faker::Lorem.sentence,
      created_at: rand(1..21).days.ago
    )
  end
end

Event.all.each do |e|
  e.create_estimate
end

Estimate.all.each do |e|
  10.times do
    e.items.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence,
      amount: rand(3...1000),
      qty: rand(1..2),
      role: 'revenue'
    )
  end
  
  10.times do
    e.items.create(
      name: Faker::App.name,
      description: Faker::Lorem.sentence,
      amount: rand(3...200),
      qty: rand(1..2),
      role: 'expense'
    )
  end
end
