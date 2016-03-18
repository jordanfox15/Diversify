# require 'rails_helper'

# describe Api::SessionsController do
#   describe "POST #create" do

#     context "with valid password" do
#       it "initiates a new session" do
#         user = User.create([first_name: "Yuffie",
#                             last_name: "Kisaragi",
#                             email: "shuriken@weapon.com",
#                             password: "mymateria",
#                             password_confirmation: "mymateria"])
#         token = AuthToken.issue(user_id: user[0].id)
#       $redis.hset(token, 'user_id', user[0].id)
#       $redis.expire(token, 60.minutes.to_i)

#         post :create, session: {email: "shuriken@weapon.com",
#                                 password: "mymateria"}
#         expect(current_user).to eq user
#       end
#     end

#   end
# end

