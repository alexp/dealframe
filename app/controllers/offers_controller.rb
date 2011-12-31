# coding: utf-8
class OffersController < ApplicationController
  def index

    if !params[:tag].blank?
      @offers = Offer.where(
        "end_date >= :now",
        {:now => Time.now}).tagged_with(params[:tag])
    else
      @offers = Offer.active
    end

    @categories = Category.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @offers }
      format.js { render :partial => 'shared/deallist', :locals => {:offers => @offers} }
    end
  end

  def show
    #redirect_to :action => 'purchase'

    @offer = Offer.find(params[:id])

    respond_to do |format|
      format.html { redirect_to :purchase  }
      format.xml  { render :xml => @offer }
      format.js { render :partial => 'offer_body' }
    end

  end

  def new
    @company = Company.new
    @offer = Offer.new

    if !signed_in?
      @user = User.new
    else
      @user = current_user
    end

    render :layout => 'purchase'
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def create
    if signed_in?
      @company = Company.new
      @offer = Offer.new
      @user = current_user

      if !params[:company][:id].blank?
        company_selected = true
        @offer = Offer.new(params[:offer])
        @offer.company = Company.find(params[:company][:id])

        if @offer.save
          redirect_to :controller => "users", :action => "companies"
        else
          render :action => "new", :layout => "purchase"
        end
      else
        puts "company not selected"
        # check if user has no companies
        if @user.companies.empty? or !params[:add_company_clicked].blank? && params[:add_company_clicked]="true"
          puts "add company clicked"
          @company = Company.new(params[:company])
          @company.user = current_user
          @offer = @company.offers.build(params[:offer])
          if @company.save
            redirect_to :controller =>"users", :action => "companies", :id => @company.id
          else
            render :action => "new", :layout => "purchase"
          end
        else
          # company not selected and not defined in new form
          @company.errors.add :id, :custom_company_id # "wybierz firmę z listy lub dodaj nową"
          render :action => "new", :layout => "purchase"
        end
      end
    else
      @company = Company.new(params[:company])
      @offer = @company.offers.build(params[:offer])
      @user = User.new(params[:user])

      if @user.save
        sign_in @user
        if @company.save
          redirect_to root_path
        else
          render :action => "new", :layout => "purchase"
        end
      else
        render :action => "new", :layout => "purchase"
      end
    end
  end

  def update
    @offer = Offer.find(params[:id])

    respond_to do |format|
      if @offer.update_attributes(params[:offer])
        format.html { redirect_to(@offer, :notice => 'Offer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.xml
  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to(offers_url) }
      format.xml  { head :ok }
    end
  end

  def purchase
    @offer = Offer.find(params[:id])
    render :layout => "purchase"
  end
end
