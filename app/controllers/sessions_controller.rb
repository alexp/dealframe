# coding: utf-8
class SessionsController < ApplicationController 
  
  layout "sessions"

  def new
    @title = "Zaloguj"
  end

  def create
    
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

  def destroy
    sign_out
    redirect_to root_path
  end
end
