class MatchMailer < ApplicationMailer

  def match_mail(email, name)
    @email = email
    @name = name
    mail(to: @email,
         subject: 'You have a new match!',
         message: @name)
  end

end
