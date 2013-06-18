# coding utf-8
class Company < ActiveRecord::Base
  has_many :offers
  has_many :couppons
  
  belongs_to :category
  belongs_to :user

  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower 

  has_attached_file :logo, 
    :default_url => "/images/:styles/missing.png",
    :styles => { :normal => "100x55", :square => "100x100", :big => "120x80"  }

  validates_attachment_presence :logo
  validates :full_name, :presence => true, :length => { :maximum => 100 }
  validates :category_id, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :zip_code, :presence => true
  validates :email, :presence => true

  after_create :notify

  def expired_offers 
    self.offers.where("end_date < :now", {:now => Time.now}) if self.verified?
  end

  def active_offers
    self.offers.where("end_date >= :now", {:now => Time.now}) if self.verified?
  end
  
  def verified?
    verified
  end

  def fresh_offers
    self.offers.where("end_date >= :now and created_at > :last_day", {:now => Time.now, :last_day => Time.now - (60*60*48) }) if self.verified?
    #self.offers
  end

  def self.not_verified
    where("verified = false")
  end

  private
  def notify
    Notifier.new_company(self).deliver 
  end
end
