class Category < ActiveRecord::Base
  has_many :offers

  # FIXME: zwraca złe wyniki!  
  def active_offers 
    Offer.where("end_date >= :now", {:now => Time.now }, :category => Category)
  end
  
end
