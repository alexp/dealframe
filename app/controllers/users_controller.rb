class UsersController < ApplicationController

  def show
    if signed_in?
      @user = User.find(params[:id])
      redirect_to :action => 'couppons'
    else
      redirect_to '/signin'
    end
  end

  def account
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Twoje konto"
      render :layout => 'user'
    else
      redirect_to '/signin'
    end
  end

  def couppons
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Twoje kupony"
      render :layout => 'user'
    else
      redirect_to '/signin'
    end
  end

  def following
    if signed_in?
      @user = User.find(params[:id])
      @page_name = "Obserwowane miejsca"
      render :layout => 'user'
    else 
      redirect_to '/signin'
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Witaj w Dealframe"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
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
