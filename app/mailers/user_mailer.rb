class UserMailer < ActionMailer::Base

  def reg_email(user)
    @user = user
    mail(to: @user.email)
  end

end
