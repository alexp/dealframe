class Category < ActiveRecord::Base
  has_many :offers

  def active_offers 
    self.offers.where("end_date >= :now", {:now => Time.now}) 
  end
  
end
