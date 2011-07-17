# coding: utf-8

class CoupponsController < ApplicationController

  def new
    @couppon = Couppon.new
  end

  def print
    if !signed_in?
      flash[:error] = "Przepraszamy, nie masz uprawnień do oglądania tej strony"
      redirect_to root_path
    else
      @couppon = Couppon.find(params[:id])
      if current_user.couppons.include?(@couppon)
        respond_to do |format|
          format.html
          format.pdf do
            render :pdf => "test.pdf",
                   :template => 'couppons/show.pdf.haml',
                   :orientation => 'Landscape',
                   :encoding => 'utf-8'
          end
        end
      else 
        flash[:error] = "Przepraszamy, nie masz uprawnień do oglądania tej strony"
        redirect_to root_path
      end
    end  
  end

  def payment
    
    @offer = Offer.find(params[:offer_id])
    quantity = @offer.price * params[:quantity][:value].to_i
    
    if !signed_in?
      if params[:user][:email].blank?
        flash[:error] = "Wprowadź swój email"
        redirect_to :back
      else
        @user = User.new(params[:user])
        if @user.save
          sign_in @user
          flash[:success] = "signed in!!"
        else
          flash[:error] = @user.errors
          redirect_to :back
        end
      end
    else
      @user = current_user
    end
    
    case params[:payment_method]
      when "paypal"
        if !flash[:error] 
          paypal_payment(@offer, params[:quantity][:value])
        end
      when "dotpay"
        
        if !flash[:error]
          safe_desc = CGI::escape(@offer.invoice_description)
          amount = params[:quantity][:value].to_i * @offer.price
          redir_url = url_for(:controller => 'users', :action => 'show', :id => @user.id)
          if signed_in?
            user_email = current_user.email
          else
            user_email = params[:user][:email]
          end

          @couppon = Couppon.new 
          @couppon.user = @user
          @couppon.company = @offer.company
          @couppon.offer = @offer
          @couppon.status = 0
          @couppon.couppon_code = @couppon.id.to_i + @couppon.offer.id.to_i
          @couppon.security_code = @couppon.generate_security_code(6)
          @couppon.expiration_date = @offer.expiration_date

          if @couppon.save
            redirect_to 'https://ssl.dotpay.pl/?id=47118&amount='+amount.to_s+"&currency=PLN&description="+safe_desc+"&URL=#{redir_url}&email="+user_email+"&country=POL&control=#{@couppon.id}"
            
            flash[:success] = "Kupiłeś kupon:#{@offer.invoice_description}"
          end
        end 

      when "cc"
        puts "karta"
      end
  end
  
  def complete
  
  end

  def verifying
    if request.remote_ip == "195.150.9.37"
      @couppon = Couppon.find(params[:control])
      
      if params[:t_status] == '2' and !@couppon.nil?

        @couppon.status = 1

        if @couppon.save
          render :text => "OK"
        end
      end
    else
      render :status => :forbidden, :text => "Unauthorized access"
    end
  end

  def ipn_notification
    
  end
  
  private

  def paypal_payment(offer, quantity)
  
    price = offer.price * quantity.to_i

    pay_request = PaypalAdaptive::Request.new
    
    data = {
      "returnUrl" => "http://localhost:3000/couppons/complete", 
      "requestEnvelope" => {"errorLanguage" => "en_US"},
      "currencyCode"=>"PLN",  
      "receiverList"=>{"receiver"=>[{"email"=>"chuj_1305557281_biz@gmail.com", "amount"=>price}]},
      "cancelUrl"=>"http://localhost:3000/offers/#{offer.id}",
      "actionType"=>"PAY",
      "ipnNotificationUrl"=>"http://localhost:3000/couppons/ipn_notification"
    }

    pay_response = pay_request.pay(data)

    if pay_response.success?
      redirect_to pay_response.approve_paypal_payment_url
    else
      puts pay_response.errors.first['message']
      flash[:error] = "ERRORRR!!!!!!"
      redirect_to @offer
    end
  end
end
