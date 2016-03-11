require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  has_many :user_interests
  has_many :interests, through: :user_interests
  has_many :first_user_matches, foreign_key: "first_user_id", class_name: "Match"
  has_many :second_user_matches, foreign_key: "second_user_id", class_name: "Match"

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
