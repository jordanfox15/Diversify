# require 'rails_helper'

# describe Demographic do

#   it "is valid with age, gender, race, sex_or, country, religion and ses" do
#     demographic = Demographic.new(
#       age: 21,
#       gender: 'Male',
#       race: 'White',
#       sex_or: 'Heterosexual',
#       country: 'East',
#       religion: 'Lifestream Worship',
#       ses: 'Low-SES')
#     expect(demographic).to be_valid
#   end

#   it "is invalid without an age" do
#     demographic = Demographic.new(
#       age: nil,
#       gender: 'Male',
#       race: 'White',
#       sex_or: 'Heterosexual',
#       country: 'East',
#       religion: 'Lifestream Worship',
#       ses: 'Low-SES')
#     demographic.valid?
#     expect(demographic.errors[:age]).to include("can't be blank")
#   end

#   it "is invalid without a gender" do
#     demographic = Demographic.new(
#       age: 21,
#       gender: '',
#       race: 'White',
#       sex_or: 'Heterosexual',
#       country: 'East',
#       religion: 'Lifestream Worship',
#       ses: 'Low-SES')
#     demographic.valid?
#     expect(demographic.errors[:gender]).to include("can't be blank")
#   end

#   it "is invalid without a race" do
#     demographic = Demographic.new(
#       age: 21,
#       gender: 'Male',
#       race: '',
#       sex_or: 'Heterosexual',
#       country: 'East',
#       religion: 'Lifestream Worship',
#       ses: 'Low-SES')
#     demographic.valid?
#     expect(demographic.errors[:race]).to include("can't be blank")
#   end

#   it "is invalid without a sexual orientation" do
#     demographic = Demographic.new(
#       age: 21,
#       gender: 'Male',
#       race: 'White',
#       sex_or: '',
#       country: 'East',
#       religion: 'Lifestream Worship',
#       ses: 'Low-SES')
#     demographic.valid?
#     expect(demographic.errors[:sex_or]).to include("can't be blank")
#   end

#   it "is invalid without a country" do
#     demographic = Demographic.new(
#       age: 21,
#       gender: 'Male',
#       race: 'White',
#       sex_or: 'Heterosexual',
#       country: '',
#       religion: 'Lifestream Worship',
#       ses: 'Low-SES')
#     demographic.valid?
#     expect(demographic.errors[:country]).to include("can't be blank")
#   end

#   it "is invalid without a religion" do
#     demographic = Demographic.new(
#       age: 21,
#       gender: 'Male',
#       race: 'White',
#       sex_or: 'Heterosexual',
#       country: 'East',
#       religion: '',
#       ses: 'Low-SES')
#     demographic.valid?
#     expect(demographic.errors[:religion]).to include("can't be blank")
#   end

#   it "is invalid without a Socioeconomic Status" do
#     demographic = Demographic.new(
#       age: 21,
#       gender: 'Male',
#       race: 'White',
#       sex_or: 'Heterosexual',
#       country: 'East',
#       religion: 'Lifestream Worship',
#       ses: '')
#     demographic.valid?
#     expect(demographic.errors[:ses]).to include("can't be blank")
#   end

# end
