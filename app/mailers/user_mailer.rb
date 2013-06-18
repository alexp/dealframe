# coding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "no-reply@kanei.pl"

  def welcome_email(user)
    @user = user
    @url = "http://kanei.pl/signin"

    mail(:to => user.email, 
         :subject=> "#{user.name}, witaj w Kanei.pl")
  end

  def new_password(user, password)
    @user = user
    @password = password

    mail(:to => user.email,
         :subject=> "#{user.name}, nowe hasło dla Ciebie")
  end

  def couppon_bought(user, couppon)
    @user = user
    @couppon = couppon 
    
    mail(:to => @user.email, 
         :subject => "#{@user.name}, twój bilet na szkolenie")
  end

end
