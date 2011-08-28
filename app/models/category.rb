class Category < ActiveRecord::Base
  has_many :offers
  has_many :companies

  def active_offers 
    self.offers.where("end_date >= :now", {:now => Time.now}) 
  end
  
end
