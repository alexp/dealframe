class CoupponsController < ApplicationController

  def new


  end

  def generate_security_code(length)
    return ActiveSupport::SecureRandom.hex(length)
  end

  def purchase
  
    @offer = Offer.find(params[:id])    
    @couppon = Couppon.create(
        :security_code => generate_security_code(5),
        :couppon_code => generate_security_code(4),
        :offer_id => params[:id],
        :status => 0,
        :company_id => @offer.company.id,
        :expiration_date => @offer.expiration_date)
    
    @user = User.new
    
    pay_request = PaypalAdaptive::Request.new
 
    #TODO: move to offer methos (i.e. @offer.calculate_price)
    price = @offer.value - ((@offer.value*@offer.discount) / 100)
    data = {
      "returnUrl" => "http://94.75.125.226:3000/couppons/#{@couppon.id}/complete", 
      "requestEnvelope" => {"errorLanguage" => "en_US"},
      "currencyCode"=>"PLN",  
      "receiverList"=>{"receiver"=>[{"email"=>"chuj_1305557281_biz@gmail.com", "amount"=>price}]},
      "cancelUrl"=>"http://94.75.125.226:3000/offers/#{@offer.id}",
      "actionType"=>"PAY",
      "ipnNotificationUrl"=>"http://testserver.com/payments/ipn_notification"
    }

    pay_response = pay_request.pay(data)

    if pay_response.success?
      redirect_to pay_response.approve_paypal_payment_url
    else
      puts pay_response.errors.first['message']
      redirect_to @offer
    end
    
#respond_to do |format|
#     format.html # buy.html.erb
#     format.xml  { render :xml => @category }
#    end
  end

  def complete
    @couppon = Couppon.where(:id => params[:id]) 
  end

end
