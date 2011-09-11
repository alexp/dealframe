# coding: utf-8
class SessionsController < ApplicationController 
  
  layout "sessions"

  def new
    @title = "Zaloguj"
  end

  def create
    
    if params[:login_action] == "forgot"
      render "forgot_password"
    else 
      user = User.authenticate(params[:session][:email],
                               params[:session][:password])
      if user.nil?
        flash.now[:error] = "Niepoprawny login i/lub hasło"
        render 'new'
      else
        sign_in user
        redirect_to user
     end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end


  def forgot_password
    if !params[:session][:email].blank?
      @user = User.find_by_email(params[:session][:email])
      new_pass = ActiveSupport::SecureRandom.hex(5)
      @user.change_password=(new_pass)
      
      if @user.save
        UserMailer.new_password(@user, new_pass).deliver
        flash[:success] = "Na podany przez Ciebie adres email, wysłaliśmy nowe hasło"
        redirect_to signin_path
      end
    else 
        flash[:info] = "Wprowadź poprawny email"
    end
  end
end
