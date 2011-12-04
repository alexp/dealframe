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
      format.html { render :layout => 'purchase'}
      format.xml  { render :xml => @offer }
      format.js { render :partial => 'offer_body' } 
    end 

  end

  def new
    @company = Company.new
    @offer = Offer.new
    render :layout => 'purchase'
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def create

    # if signed_in?
    # ...
    #   select company or add new
    #
    #   if selected_company
    #     zapisz oferte z wybrana firma
    #   else
    #     if company.save
    #       if offer.save
    #         sukces
    #       else
    #         zjebana oferta
    #       end
    #     else
    #       zjebana firma
    #     end
    #   end
    #
    # else
    #
    #   if has_account?
    #     ... 
    #   else
    #     new company, new offer, 
    #     leave credentials, new user 
    #   end
    # end

    if signed_in?
      # did the user select company from select box?
      
      @company = Company.new
      @offer = Offer.new

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
        if !params[:add_company_clicked].blank? && params[:add_company_clicked]="true"
          puts "add company clicked"
          @company = Company.new(params[:company])
          @company.user = current_user
          @offer = @company.offers.build(params[:offer])
          if @company.save
            redirect_to :controller =>"users", :action => "companies"
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
      return
    end
    /
    @offer = Offer.new(params[:offer])
    @offer.tag_list = params[:offer][:tag_list]

    if signed_in?
      if !params[:company].blank? && !params[:company][:id].blank? 
        @company = Company.find(params[:company][:id])
        company_selected = true
      end
    end
    
    if !company_selected  #@company.nil?
      if !params[:add_company_clicked]
        @company.errors.add :id, "wybierz firmę lub dodaj nową"
      else 
        @company = Company.new(params[:company])
        @company.zip_code = params[:zip_code_left] + "-" + params[:zip_code_right]
        @company.verified = false 
        @company.user = current_user if signed_in?
      end
    end
    
    @offer.company = @company

    if @offer.save
      if !company_selected
        if @company.save
          flash[:error] = "zjebana firma"
          render :action => "new", :layout => "purchase"
        end
      end

      if signed_in?
        redirect_to current_user
      else 
        redirect_to signin_path
      end
    else
      flash[:error] = "zjebana oferta"
      render :action => "new", :layout => "purchase"
    end
    /
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
