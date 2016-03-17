class Match < ActiveRecord::Base

 belongs_to :first_user, class_name: "User"
 belongs_to :second_user, class_name: "User"
 belongs_to :topic
 has_many :messages

end
