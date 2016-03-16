# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

race = ["White", "Black", "Native American", "Latino/Hispanic", "Asian", "Pacific Islander", "Middle Eastern"]

religions = ["Catholicism", "Christianity", "Judaism", "Islam", "Atheism", "Buddhism", "Shintoism", "Hinduism", "Taoism", "Maori", "Wiccan"]

sex_ors = ["Heterosexual", "Gay/Lesbian", "Queer", "Bisexual", "Transgender", "Asexual"]

ses = ["Upper-SES", "Middle-SES", "Low-SES"]

countries = ["US", "Mexico", "Canada", "England", "Russia", "Turkey", "Ethiopia", "France", "Germany", "Brazil", "South Africa", "India", "Iran", "Romania", "Ireland", "Scotland", "Sweden", "Chile", "Argentina", "Kuwait", "Saudi Arabia", "Jordan", "China", "Japan", "Denmark", "Cambodia", "Afghanistan", "Mongolia", "Lithuania", "Czech Republic", "Cuba", "Australia", "New Zealand"]

interests = ["Acting", "Animals", "Anime", "Arts", "Astronomy", "Baking", "Baseball", "Basketball", "Beauty", "Billiards", "Boating", "Books", "Bowling", "Camping", "Carpentry", "Cars", "Cartoons", "Cats", "Church Activities", "Climbing", "Collecting", "Computers", "Concerts", "Cooking", "Cycling", "Dance", "Dogs", "Drawing", "Driving", "Extreme Sports", "Fashion", "Film making", "Fishing", "Fitness", "Food", "Football", "Gambling", "Games", "Gardening", "Golf", "Health", "Hiking", "History", "Hockey", "Horseback Riding", "Hunting", "Ice skating", "Juggling", "Kayaking", "Knitting", "Literature", "Martial Arts", "Magic", "Motor Sports", "Mountain Biking", "Motorcycling", "Movies", "Music", "Nature", "Paintball", "Painting", "Pets", "Philosophy", "Photography", "Poetry", "Politics", "Pottery", "Psychology", "Puzzles", "Reading", "Religion", "Science", "Singing", "Skateboarding", "Skiing", "Skydiving", "Snowboarding", "Soccer", "Sports", "Statistics", "Surfing", "Swimming", "Tattoos", "Teaching", "Technology", "Television", "Tennis", "Theater", "Travel", "Water Sports", "Wine Tasting", "Wrestling", "Writing", "Yoga"]

topics = ["#MarchMadness", "#Elections2016", "Iphone or Android?", "Cats or Dogs?", "#BlackLivesMatter", "Is global warming an issue?", "How many countries have you visited?", "Favorite cultural foods?", "What are some issues impacting your culture?", "Are you religious?", "Do you play any instruments?", "What do you think about the supreme court gay marriage verdict?", "How do you feel about immigration?", "Beach or the forest?", "If you could move anywhere, where would you go?", "Do you like musicals?", "What's your least favorite city?", "Books", "Mental Health", "Healthcare", "Gun rights", "Feminism", "Gender Change", "Game of Thrones", "North Korea", "War", "Refugee Crisis", "Islamophobia", "Favorite TV show", "Favorite board/card game", "Walking Dead", "Marvel or DC?", "Favorite movie"]

User.delete_all
Demographic.delete_all
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
                       password_confirmation: "password"])
end

User.all.each do |user|
  demographics = Demographic.create([age: rand(18..80),
                                     gender: ["male", "female", "other"].sample,
                                     race: race.sample,
                                     sex_or: sex_ors.sample,
                                     country: countries.sample,
                                     religion: religions.sample,
                                     ses: ses.sample,
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

topics.each do |topic|
  Topic.create(name: topic)
end




