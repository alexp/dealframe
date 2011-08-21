class OffersController < ApplicationController
  def index
    
    if !params[:tag].blank?
      @offers = Offer.where(
        "end_date >= :now", 
        {:now => Time.now}).tagged_with(params[:tag])
    else
      @offers = Offer.where("end_date >= :now", {:now => Time.now}).all
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
      format.html # show.html.erb
      format.xml  { render :xml => @offer }
      format.js { render :partial => 'offer_body' } 
    end 

  end

  def new
    @offer = Offer.new
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def create
    @offer = Offer.new(params[:offer])
    @offer.tag_list = params[:offer][:tag_list]

    respond_to do |format|
      if @offer.save
        format.html { redirect_to(@offer, :notice => 'Offer was successfully created.') }
        format.xml  { render :xml => @offer, :status => :created, :location => @offer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @offer.errors, :status => :unprocessable_entity }
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
