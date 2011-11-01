# coding: utf-8
class Notifier < ActionMailer::Base
  default :from => 'no-reply@dealframe.pl'

  def new_company(company)
    @company = company
    @url = company_url(@company)
    mail(:to => "alex.pszczolkowski@gmail.com", 
         :subject => "nowa firma w serwisie")
         #:bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"])
  end

  def new_offer(offer)
    @offer = offer
    @url = offer_url(@offer)
    @company_url = company_url(@offer.company)
    mail(:to => "alex.pszczolkowski@gmail.com", 
         :subject => "nowa firma w serwisie")
         #:bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"])
  end
end
