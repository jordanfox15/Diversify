# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

race = ["White", "Black", "Native American", "Latino/Hispanic", "Asian", "Pacific Islander", "Middle Eastern"]

religions = ["Catholicism", "Christiany", "Judaism", "Islam", "Atheism", "Buddhism", "Shintoism", "Hinduism", "Taoism", "Maori", "Wiccan"]

sex_ors = ["Heterosexual", "Gay/Lesbian", "Queer" "Bisexual", "Transgender", "Asexual"]

ses = ["Upper-SES", "Middle-SES", "Low-SES"]

countries = ["US", "Mexico", "Canada", "England", "Russia", "Turkey", "Ethiopia", "France", "Germany", "Brazil", "South Africa", "India", "Iran", "Romania", "Ireland", "Scotland", "Sweden", "Chile", "Argentina", "Kuwait", "Saudi Arabia", "Jordan", "China", "Japan", "Denmark", "Cambodia", "Afghanistan", "Mongolia", "Lithuania", "Czech Republic", "Cuba", "Australia", "New Zealand"]

100.times do
  users = User.create([first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       password: "password",
                       race: race.sample,
                       email: Faker::Internet.email,
                       religion: religions.sample,
                       sex_or: sex_ors.sample,
                       ses: ses.sample,
                       country: countries.sample,
                       gender: ["male", "female", "other"].sample,
                       age: rand(18..80)])
end

250.times do
  matches = Match.create([first_user_id: rand(1..100),
                          second_user_id: rand(1..100)])
end

Match.all.each do |match|
  message = Message.create([text: Faker::Lorem.sentences,
                            sender_id: match.first_user_id,
                            recipient_id: match.second_user_id,
                            match_id: match.id])

  message = Message.create([text: Faker::Lorem.sentences,
                            sender_id: match.second_user_id,
                            recipient_id: match.first_user_id,
                            match_id: match.id])
end









