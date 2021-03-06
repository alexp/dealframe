# coding: utf-8
class Offer < ActiveRecord::Base
  belongs_to :category
  belongs_to :company
  
  acts_as_taggable
  has_attached_file :photo, 
    #:path => "offers/:id/:style/:basename.:extension",
    :default_url => "/images/:styles/missing.png",
    :styles => { :normal => "140x90" , :large => "249x160"}

  validates_attachment_presence :photo, :message => "musi być wypełnione"
  validates_acceptance_of :terms 
  validates_presence_of :fine_print, :value, :additional_info, :category, :details, :title,:description,:start_date,:expiration_date,:end_date

  validates :value, :numericality => { :less_than_or_equal_to => 1000, :greater_than_or_equal_to => 2}
  #validates :discount, :numericality => { :less_than_or_equal_to => 100, :greater_than_or_equal_to => 2}
  after_create :notify


  def is_active?
    (self.end_date >= Time.now) and (self.status == "active") and (self.company.verified == true)
  end
  
  def expired?
    (self.end_date <= Time.now) #and (self.status == "active") and (self.company.verified == true)
  end

  def price
    value - ((value * discount) / 100)
  end

  def finish_time
    (end_date - Time.now).to_i
  end

  def hours
    self.finish_time / 3600
  end

  def minutes
    (self.finish_time / 60) % 60
  end

  def seconds
    self.finish_time % 60
  end

  def self.active 
    self.joins(:company).where("end_date >= :now and companies.verified = true", {:now => Time.now})
  end

  def couppon_count
    Couppon.count(:conditions => ["offer_id = ? and status = 'wykonany'", id])
  end

  private
  def notify
    Notifier.new_offer(self).deliver
  end
end
