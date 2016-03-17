class User < ActiveRecord::Base
  has_secure_password

  has_one :demographic
  has_one :gender, through: :demographic
  has_one :race, through: :demographic
  has_one :sex_or, through: :demographic
  has_one :country, through: :demographic
  has_one :religion, through: :demographic
  has_one :ses, through: :demographic
  has_many :user_interests
  has_many :interests, through: :user_interests
  has_many :first_user_matches, foreign_key: "first_user_id", class_name: "Match"
  has_many :second_user_matches, foreign_key: "second_user_id", class_name: "Match"

validates :first_name, :last_name, :password_digest, presence: true
validates :email, presence: true, uniqueness: true
validates_format_of :email, :with => /.+@.+\..+/i

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
def age
  self.demographic.age
end

end

