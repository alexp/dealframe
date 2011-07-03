# coding: utf-8

class CoupponsController < ApplicationController

  def new
    @couppon = Couppon.new
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
                redirect_to 'https://ssl.dotpay.pl/?id=47118&amount='+amount.to_s+"&currency=PLN&description="+safe_desc+"&URL=#{redir_url}&email="+params[:user][:email]+"&country=POL"
                flash[:success] = "Kupiłeś kupon:#{@offer.invoice_description}"
              end 
  
            when "cc"
              puts "karta"
          end
        else
          flash[:error] = @user.errors
          redirect_to :back
        end
      end
    end
  end
  
  def complete
  
  end

  def verifying
    
    if(request.remote_ip == "195.150.9.37")
      if(params[:t_status] == '2')
        @couppon = Couppon.new
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
