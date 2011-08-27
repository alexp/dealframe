class UserMailer < ActionMailer::Base
  default :from => "no-reply@dealframe.pl"

  def welcome_email(user)
    @user = user
    @url = "http://94.75.125.226:3000/signin"

    mail(:to => user.email, 
         :subject=> "#{user.name}, witaj w Dealframe.pl")
  end
end
