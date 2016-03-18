require 'rails_helper'

describe Api::UsersController do
  describe "POST #create" do

    context "with valid attributes" do
      it "saves the new user in the database" do

        expect {
          post :create, user: {first_name: "Vincent",
                                  last_name: "Valintine",
                                  email: "ilovelucrecia@smitten.com",
                                  password: "downwithhojo",
                                  password_confirmation: "downwithhojo"}
        }.to change(User, :count).by(1)

      end
    end

    # context "with invalid attributes" do
    #   it "does not save the new user to the database" do

    #     expect {
    #       post :create, user: {first_name: "Aeris",
    #                            last_name: "Gainsborough",
    #                            email: "flowergirl",
    #                            password: "iamdead",
    #                            password_confirmation: "iamdead"}
    #     }.not_to change(User, :count)

    #   end
    # end

  end

  # describe 'PUT #edit_profile' do
  #   before :each do
  #     @user = User.create(first_name: "Yufie",
  #                         last_name: "Kisaragi",
  #                         email: "shuriken@weapon.com",
  #                         password: "mymateria",
  #                         password_confirmation: "mymateria")
  #   end

  #   context "valid attributes" do
  #     it "changes @user's attributes" do
  #       put :edit_profile, id: @user,

  #       user: {first_name: "Yuffie"}
  #       @user.reload
  #       p @user
  #       expect(@user.first_name).to eq('Yuffie')
  #     end
  #   end

  # end

end
