# coding: utf-8
class UsersController < ApplicationController

  layout "user"

  def companies
    redirect_to 'signin' if !signed_in?
    @user = User.find(params[:id])
    @page_name = "Twoje firmy"
  end
  
  def show
    if signed_in?
      @user = User.find(params[:id])
      redirect_to :action => 'couppons'
    else
      redirect_to '/signin'
    end
  end

  def couppons
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Twoje kupony"
    else
      redirect_to '/signin'
    end
  end

  def following
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Obserwowane miejsca"
    else 
      redirect_to '/signin'
    end
  end

  def new
    @user = User.new
    render :layout => "sessions"
  end

  def edit
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Twoje konto"
      render :layout => 'user'
    else
      redirect_to '/signin'
    end
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      
      UserMailer.welcome_email(@user).deliver
      
      sign_in @user
      flash[:success] = "Witaj w Dealframe"
      redirect_to root_path
    else
      #flash[:error] = "Nie udało się dokonać rejestracji. Wszystkie pola muszą być wypełnione. Hasło musi mieć co najmniej 6 znaków."
      #flash[:error] = @user.errors
      render 'new', :layout => "sessions"
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      # very bad solution - just to get this wotking
      update_hash = {:name => params[:user][:name], 
                      :surname => params[:user][:surname],
                      :email => params[:user][:email]}

      if params[:user].has_key?(:photo) 
        update_hash[:photo] = params[:user][:photo]
      end

      if @user.update_attributes(update_hash)
        #format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.html { 
          flash[:success] = "Zmiany zostały zapisane"
          redirect_to :action => "edit" 
        }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def change_password
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Zmiana hasła"
      render :layout => 'user'
    else
      redirect_to '/signin'
    end
  end

  def update_password
    
    logger.info "update password begin"

    @user = User.find(params[:id])
    if signed_in?
      if @user.has_password?(params[:old_password])
        @user.encrypted_password_will_change!
        if @user.update_attribute(:password, params[:user][:password])
          flash[:success] = "Hasło zmienione"
          render :action => "change_password"
        end
      else 
        flash[:error] = @user.errors
        render :action => "change_password"
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

end
