class Demographic < ActiveRecord::Base

  has_one :user
  belongs_to :gender
  belongs_to :race
  belongs_to :sex_or
  belongs_to :country
  belongs_to :religion
  belongs_to :ses

end
