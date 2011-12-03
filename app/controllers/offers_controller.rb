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

    #@offer = @company.offers.build(params[:offer])
    
    @offer = Offer.new(params[:offer])
    @offer.tag_list = params[:offer][:tag_list]

    if signed_in?
      if !params[:user][:company_id].empty?
        @company = Company.find(params[:user][:company_id])
        company_selected = true
      end
    end
    
    if @company.nil?
      @company = Company.new(params[:company])
      @company.zip_code = params[:zip_code_left] + "-" + params[:zip_code_right]
      @company.verified = false 
      @company.user = current_user if signed_in?
    end

    @offer.company = @company

    if @offer.save
      if !company_selected
        if !@company.save
          render :action => "new", :layout => "purchase"
        end
      end

      if signed_in?
        redirect_to current_user
      else 
        redirect_to signin_path
      end
    else
      render :action => "new", :layout => "purchase"
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
