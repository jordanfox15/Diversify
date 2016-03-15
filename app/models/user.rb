class User < ActiveRecord::Base
  has_secure_password

  has_one :demographic
  has_many :user_interests
  has_many :interests, through: :user_interests
  has_many :first_user_matches, foreign_key: "first_user_id", class_name: "Match"
  has_many :second_user_matches, foreign_key: "second_user_id", class_name: "Match"

validates :first_name, :last_name, presence: true
validates :email, :password_digest, presence: true, uniqueness: true

end

