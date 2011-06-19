# coding: utf-8

class CoupponsController < ApplicationController

  def new
  end
  
  def payment
    # kod do wyjebania (oprocz tego do paypala
    #
    # tutaj z jestesmy przekierowani z podstrony potwierdzenia
    # zakupu. Czyli /offers/:id/pruchase -> click "KUP"
    # postem wysylamy dane formularza tutaj i procesujemy caly 
    # pierdolnik.
    # * odpowiednie dzialanie wz. od  metody płatności
    # * zalozenie konta uzytkownikowi
    # * wysylka maila
    # * procesowanie platnosci
    # * z platnosci, jesli wszystko ok, przekierowanie do podlgadu kuponu.
    
    @offer = Offer.find(params[:offer_id])
    
    if !signed_in?
      if params[:user][:email].blank?
        flash[:error] = "Uzupełnij pole email"
        redirect_to :back
      else
        @user = User.new(params[:user])
        if @user.save
          sign_in @user
          flash[:success] = "signed in!!"
        else
          flash[:error] = "problem ze stworzeniem usera"
        end
      end
    end

    case params[:payment_method]
      when "paypal"
        paypal_payment(@offer, params[:qnt])
      else
        # dotpay_payment 
    end

  end
  
  def complete
  
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
