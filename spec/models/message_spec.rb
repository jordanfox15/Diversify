require 'rails_helper'

describe Message do
  it "is valid with some text" do
    message = Message.new(
      text: 'Netflix and chill?')
    expect(message).to be_valid
  end

  it "is invalid without some text" do
    message = Message.new(
      text: '')
    message.valid?
    expect(message.errors[:text]).to include("can't be blank")
  end
end
