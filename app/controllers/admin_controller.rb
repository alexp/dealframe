class AdminController < ApplicationController

  layout "admin"

  def index
  end

  def companies
    @companies = Company.not_verified
  end

  def verify
    @company = Company.find(params[:id])
    @company.verified = true

    if @company.save
      redirect_to(admin_path, :notice => 'Company verified')  
    end   
  end

  def offers
    @offers = Offer.all
  end

end
