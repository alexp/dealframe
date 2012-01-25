# coding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "no-reply@dealframe.pl"

  def welcome_email(user)
    @user = user
    @url = user_url(@user)

    mail(:to => user.email, 
         :subject=> "#{user.name}, witaj w Dealframe.pl")
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
    
    mail(:to => user.email, 
         :subject => "#{@user.name}, twój kupon")
  end

end
