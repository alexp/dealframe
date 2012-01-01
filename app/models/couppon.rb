class Couppon < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :offer

  STATUSES = ['niezweryfikowany', 'nowy', 'wykonany', 'odmowa', 'anulowana']
  validates_inclusion_of :status, :in => STATUSES,
              :message => "{{value}} must be in #{STATUSES.join ','}"

  scope :expired,
    :conditions => [ "expiration_date < ?", Time.now.strftime("%Y-%m-%d %H:%M:%S") ]
  scope :paid,
    :conditions => [ "status = 'wykonany' and used = false and expiration_date > ?", Time.now.strftime('%Y-%m-%d %H:%M:%S') ]
  scope :payment_pending,
    :conditions => [ "status ='niezweryfikowany' or status = 'nowy'"  ]
  scope :cancelled,
    :conditions => { :status => 'odmowa' }
  scope :used,
    :conditions => { :used => true }

  def status_name
    STATUSES[status]
  end

  def generate_security_code(length)
    return ActiveSupport::SecureRandom.hex(length)
  end

  def valid?
    return expiration_date > Time.now && 
      status == 'wykonany' &&
      used == false 
  end

  def is_expired?
    return true if expiration_date < Time.new
  end

  def self.redeem(code)
    couppon = find_by_couppon_code(code)
    return nil if couppon.nil?

    couppon.used = true
    return couppon if couppon.save
  end
end
