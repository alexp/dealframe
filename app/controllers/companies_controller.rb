# coding: utf-8
class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.xml
  def index
    @companies = Company.all

    respond_to do |format|
      format.html { render :layout => "company"} # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @company = Company.find(params[:id])

    if @company.lat.nil? && @company.long.nil?
      @company.lat = 0
      @company.long = 0
    end
      

    @categories = Category.all
    @content_for_company_profile = true
    @user = current_user
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
    if signed_in?
      @company = Company.find(params[:id])
      if current_user.companies.include?(@company)
        @user = current_user
        @page_name = "Edycja firmy"
        render :action => "edit", :layout => "user"
      else
        redirect_to @company
      end
    end
  end

  # POST /companies
  # POST /companies.xml
  def create
    if signed_in?
      @company = Company.new(params[:company])

      if current_user.companies.include?(@company)
        respond_to do |format|
          if @company.save
            format.html { redirect_to(@company, :notice => 'Utworzono nową firmę') }
            format.xml  { render :xml => @company, :status => :created, :location => @company }
          else
            format.html { render :action => "new" }
            format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
          end
        end
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @company = Company.find(params[:id])
    @user = current_user
    if current_user.companies.include?(@company)
      respond_to do |format|
        if @company.update_attributes(params[:company])
          format.html { redirect_to(@company, :notice => "Pomyślnie zaktualizowano dane firmy. Chcesz coś jeszcze poprawić? #{view_context.link_to('Edytuj ponownie firmę.', edit_company_path)}".html_safe) }
          format.xml  { head :ok }
        else
          format.html { 
            @page_name = "Edycja firmy"
            render :action => "edit", :layout => "user"
          }
          format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end

end
