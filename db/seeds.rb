# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: 'George Marcus',
  email: 'gmarcus@golfr.com',
  password: '123456',
  password_confirmation: '123456'
)

User.create!(
  name: 'Sergiu Apostu',
  email: 'sapostu@golfr.com',
  password: '123456',
  password_confirmation: '123456'
)

User.create!(
  name: 'Alex Tandrau',
  email: 'atandrau@golfr.com',
  password: '123456',
  password_confirmation: '123456'
)

rng = Random.new
now = Time.zone.today
User.all.each do |user|
  5.times do |i|
    number_of_holes = [9, 18].sample
    total_score = number_of_holes == 9 ? rng.rand(27..89) : rng.rand(54..179)
    Score.create!(
      user: user,
      total_score: total_score,
      played_at: now - 5.days + i.days,
      number_of_holes: number_of_holes
    )
  end
end
