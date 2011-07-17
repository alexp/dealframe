class Couppon < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :offer
  
  named_scope :payed, 
    :conditions => { :status => '1' }
  named_scope :payment_pending,
    :conditions => { :status => '0'  }

  def generate_security_code(length)
    return ActiveSupport::SecureRandom.hex(length)
  end
end
