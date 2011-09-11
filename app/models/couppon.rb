class Couppon < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :offer
  
  named_scope :paid, 
    :conditions => { :status => '1', :used => false }
  named_scope :payment_pending,
    :conditions => { :status => '0'  }
  named_scope :used,
    :conditions => { :used => true }

  def generate_security_code(length)
    return ActiveSupport::SecureRandom.hex(length)
  end

  def self.redeem(code)
    couppon = find_by_couppon_code(code)
    return nil if couppon.nil?
    
    couppon.used = true
    return couppon if couppon.save
  end
end
