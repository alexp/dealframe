class UserMailer < ActionMailer::Base
  default :from => "no-reply@dealframe.pl"

  def welcome_email(user)
    @user = user
    @url = user_url(@user)

    mail(:to => user.email, 
         :subject=> "#{user.name}, witaj w Dealframe.pl")
  end
end
