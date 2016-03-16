require 'rails_helper'

describe User do

  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      first_name: 'Cloud',
      last_name: 'Strife',
      email: 'fatsword@midgar.com',
      password_digest: 'password')
    expect(user).to be_valid
  end

  it "is invalid without a last name" do
    user = User.new(
      first_name: '',
      last_name: 'Strife',
      email: 'fatsword@midgar.com',
      password_digest: 'password')
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name" do
    user = User.new(
      first_name: 'Cloud',
      last_name: '',
      email: 'bustersword@midgar.com',
      password_digest: 'password')
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(
      first_name: 'Cloud',
      last_name: 'Strife',
      email: '',
      password_digest: 'password')
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(
      first_name: 'Cloud',
      last_name: 'Strife',
      email: 'fatsword@midgar.com',
      password_digest: '')
    user.valid?
    expect(user.errors[:password_digest]).to include("can't be blank")
  end

  it "is invalid without a unique password" do
    User.create(
      first_name: 'Cloud',
      last_name: 'Strife',
      email: 'fatsword@midgar.com',
      password_digest: 'password')

    user = User.new(
      first_name: 'Tifa',
      last_name: 'Lockhart',
      email: 'punchgloves@midgar.com',
      password_digest: 'password')
    user.valid?
    expect(user.errors[:password_digest]).to include("has already been taken")
  end

  it "is invalid without a unique email" do
    User.create(
      first_name: 'Cloud',
      last_name: 'Strife',
      email: 'avalanche@midgar.com',
      password_digest: 'SOLDIERnotreally')

    user = User.new(
      first_name: 'Tifa',
      last_name: 'Lockhart',
      email: 'avalanche@midgar.com',
      password_digest: 'password')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")

  end

end
