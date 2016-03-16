class Demographic < ActiveRecord::Base

  validates :age, :gender, :race, :sex_or, :country, :religion, :ses, presence: true
end
