require 'rails_helper'

describe Interest do
  it "is valid with a name" do
    interest = Interest.new(
      name: 'Time Travel')
    expect(interest).to be_valid
  end

  it "is invalid without a name" do
    interest = Interest.new(
      name: '')
    interest.valid?
    expect(interest.errors[:name]).to include("can't be blank")
  end

it "is invalid without a unique name" do
    Interest.create(
      name: 'Time Travel')

    interest = Interest.new(
      name: 'Time Travel')
    interest.valid?
    expect(interest.errors[:name]).to include("has already been taken")
  end

end
