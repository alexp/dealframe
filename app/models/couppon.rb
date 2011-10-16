class Couppon < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :offer
  
  STATUSES = ['niezweryfikowany', 'nowy', 'wykonany', 'odmowa', 'anulowana']
  validates_inclusion_of :status, :in => STATUSES,
              :message => "{{value}} must be in #{STATUSES.join ','}"

  named_scope :paid, 
    :conditions => { :status => 'wykonany', :used => false }
  named_scope :payment_pending,
    :conditions => [ "status ='niezweryfikowany' or status = 'nowy'"  ]
  named_scope :cancelled,
    :conditions => { :status => 'odmowa' }
  named_scope :used,
    :conditions => { :used => true }

  def status_name
    STATUSES[status]
  end

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
