class Offer < ActiveRecord::Base
  belongs_to :category
  belongs_to :company
  
  acts_as_taggable
  has_attached_file :photo, :styles => { :normal => "140x90" }

  validates_attachment_presence :photo

  after_save :notify


  def is_active?
    (self.end_date >= Time.now) and (self.status == "active") and (self.company.verified == true)
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
    self.joins(:company).where("end_date >= :now and companies.verified = 1", {:now => Time.now})
  end

  private
  def notify
    Notifier.new_offer(self).deliver
  end
end
