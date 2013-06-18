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
      @page_name = "Twoje szkolenia"
    else
      redirect_to '/signin'
    end
  end

  def following
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Obserwowane firmy"
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
    @page_name = "Twoje konto"
    @user = User.find(params[:id])
    # very bad solution - just to get this wotking
    update_hash = {:name => params[:user][:name],
                    :surname => params[:user][:surname],
                    :email => params[:user][:email]}

    if params[:user].has_key?(:photo)
      update_hash[:photo] = params[:user][:photo]
    end

    if @user.update_attributes(update_hash)
        flash[:success] = "Zmiany zostały zapisane"
        redirect_to :action => "edit"
    else
      render :action => "edit"
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

    @page_name = "Zmiana hasła"
    @user = User.find(params[:id])
    if signed_in?
      if @user.has_password?(params[:user][:old_password])
        if params[:user][:password] == params[:user][:password_confirmation]
          @user.encrypted_password_will_change!
          if @user.update_attribute(:password, params[:user][:password])
            flash[:success] = "Hasło zmienione"
          else
            flash[:error] = "nieudany zapis"
          end
        else
          @user.errors.add :password, "nie odpowiada potwierdzeniu"
          @user.errors.add :password_confirmation, "nie odpowiada hasłu"
        end
      else
        @user.errors.add :old_password, "jest niepoprawne"
      end
      render :action => "change_password"
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

  def company_offers
    if signed_in?
      @user = User.find(params[:id])
      if(current_user == @user)
        @company = Company.find(params[:company_id])
        @page_name = "Oferty"
      else
        redirect_to current_user
      end
    else 
      redirect_to signin_path
    end
  end


  def edit_offer
    if signed_in? 
      @user = User.find(params[:id])
      if @user == current_user
        @offer = Offer.find(params[:offer_id])
        @page_name="Edycja oferty"
      else 
        flash[:notice] = "Nie znaleziono rekordu"
        redirect_to current_user
      end
    else
      redirect_to signin_path
    end
  end

  def remove_account
    if signed_in?
      @user = current_user
      sign_out
      User.destroy(@user)
      flash[:success] = "Przykro nam, że nas opuszczasz. Twoje konto zostało usunięte. Nie obrażamy się! Możesz zawsze założyć nowe konto!! :)"
      redirect_to root_path
    end
  end
end
