# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

race = ["White", "Black", "Native American", "Latino/Hispanic", "Asian", "Pacific Islander", "Middle Eastern"]

religions = ["Catholicism", "Christiany", "Judaism", "Islam", "Atheism", "Buddhism", "Shintoism", "Hinduism", "Taoism", "Maori", "Wiccan"]

sex_ors = ["Heterosexual", "Gay/Lesbian", "Queer", "Bisexual", "Transgender", "Asexual"]

ses = ["Upper-SES", "Middle-SES", "Low-SES"]

countries = ["US", "Mexico", "Canada", "England", "Russia", "Turkey", "Ethiopia", "France", "Germany", "Brazil", "South Africa", "India", "Iran", "Romania", "Ireland", "Scotland", "Sweden", "Chile", "Argentina", "Kuwait", "Saudi Arabia", "Jordan", "China", "Japan", "Denmark", "Cambodia", "Afghanistan", "Mongolia", "Lithuania", "Czech Republic", "Cuba", "Australia", "New Zealand"]

User.delete_all
Match.delete_all
Message.delete_all
Interest.delete_all
Topic.delete_all
UserInterest.delete_all

20.times do
  users = User.create([first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       email: Faker::Internet.email,
                       password: "password",
                       password_confirmation: "password",
                       age: rand(18..80)]),
                       gender: ["male", "female", "other"].sample,
                       race: race.sample,
                       sex_or: sex_ors.sample,
                       country: countries.sample,
                       religion: religions.sample,
                       ses: ses.sample
end

user_ids = []
User.all.each do |user|
  user_ids.push(user.id)
end

20.times do
  matches = Match.create([first_user_id: user_ids.sample,
                          second_user_id: user_ids.sample])
end

Match.all.each do |match|
  message = Message.create([text: Faker::Lorem.paragraph,
                            sender_id: match.first_user_id,
                            recipient_id: match.second_user_id,
                            match_id: match.id])

  message = Message.create([text: Faker::Lorem.paragraph,
                            sender_id: match.second_user_id,
                            recipient_id: match.first_user_id,
                            match_id: match.id])
end

50.times do
  interests = Interest.create([name: Faker::Commerce.product_name])
end

interest_ids = []
Interest.all.each do |interest|
  interest_ids.push(interest.id)
end

User.all.each do |user|
  5.times do
    user_interests = UserInterest.create([ user_id: user.id,
                                           interest_id: interest_ids.sample])
  end
end

15.times do
  topics = Topic.create([ name: Faker::Commerce.department(1)])
end




