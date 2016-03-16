# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

races = ["White", "Black", "Native American", "Latino/Hispanic", "Asian", "Pacific Islander", "Middle Eastern"]

religions = ["Catholicism", "Christiany", "Judaism", "Islam", "Atheism", "Buddhism", "Shintoism", "Hinduism", "Taoism", "Maori", "Wiccan"]

sex_ors = ["Heterosexual", "Gay/Lesbian", "Queer", "Bisexual", "Transgender", "Asexual"]

genders = ["Female", "Non-binary/Other", "Male"]

seses = ["Upper-SES", "Middle-SES", "Low-SES"]

countries = ["US", "Mexico", "Canada", "England", "Russia", "Turkey", "Ethiopia", "France", "Germany", "Brazil", "South Africa", "India", "Iran", "Romania", "Ireland", "Scotland", "Sweden", "Chile", "Argentina", "Kuwait", "Saudi Arabia", "Jordan", "China", "Japan", "Denmark", "Cambodia", "Afghanistan", "Mongolia", "Lithuania", "Czech Republic", "Cuba", "Australia", "New Zealand"]

interests = ["Acting", "Animals", "Anime", "Arts", "Astronomy", "Baking", "Baseball", "Basketball", "Beauty", "Billiards", "Boating", "Books", "Bowling", "Camping", "Carpentry", "Cars", "Cartoons", "Cats", "Church Activities", "Climbing", "Collecting", "Computers", "Concerts", "Cooking", "Cycling", "Dance", "Dogs", "Drawing", "Driving", "Extreme Sports", "Fashion", "Film making", "Fishing", "Fitness", "Food", "Football", "Gambling", "Games", "Gardening", "Golf", "Health", "Hiking", "History", "Hockey", "Horseback Riding", "Hunting", "Ice skating", "Juggling", "Kayaking", "Knitting", "Literature", "Martial Arts", "Magic", "Motor Sports", "Mountain Biking", "Motorcycling", "Movies", "Music", "Nature", "Paintball", "Painting", "Pets", "Philosophy", "Photography", "Poetry", "Politics", "Pottery", "Psychology", "Puzzles", "Reading", "Religion", "Science", "Singing", "Skateboarding", "Skiing", "Skydiving", "Snowboarding", "Soccer", "Sports", "Statistics", "Surfing", "Swimming", "Tattoos", "Teaching", "Technology", "Television", "Tennis", "Theater", "Travel", "Water Sports", "Wine Tasting", "Wrestling", "Writing", "Yoga"]

User.delete_all
Demographic.delete_all
Match.delete_all
Message.delete_all
Interest.delete_all
Topic.delete_all
UserInterest.delete_all
Race.delete_all
Country.delete_all
Gender.delete_all
Ses.delete_all
SexOr.delete_all
Religion.delete_all

races.each do |race|
  Race.create([name: race])
end

countries.each do |country|
  Country.create([name: country])
end

genders.each do |gender|
  Gender.create([name: gender])
end

religions.each do |religion|
  Religion.create([name: religion])
end

sex_ors.each do |sex_or|
  SexOr.create([name: sex_or])
end

seses.each do |ses|
  Ses.create([name: ses])
end

gender_objs = Gender.all
race_objs = Race.all
sex_or_objs = SexOr.all
country_objs = Country.all
religion_objs = Religion.all
ses_objs = Ses.all

20.times do
  users = User.create([first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       email: Faker::Internet.email,
                       password: "password",
                       password_confirmation: "password"])
end

User.all.each do |user|
  demographics = Demographic.create([age: rand(18..80),
                                     gender_id: gender_objs.sample.id,
                                     race_id: race_objs.sample.id,
                                     sex_or_id: sex_or_objs.sample.id,
                                     country_id: country_objs.sample.id,
                                     religion_id: religion_objs.sample.id,
                                     ses_id: ses_objs.sample.id,
                                     user_id: user.id])
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

interests.each do |interest_name|
  Interest.create(name: interest_name)
end

# 50.times do
#   interests = Interest.create([name: interests_collection.sample])
# end

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




