class UserMailer < ApplicationMailer

  def register_email(email)
    @email=email
    # @url ='https://dashboard.heroku.com/apps/fast-ridge-24283'
    mail(from: 'moniquewill1@yahoo.com',
         to: @email,
         subject: 'Welcome to Diversify')
  end

end
