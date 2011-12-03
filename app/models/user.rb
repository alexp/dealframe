require 'digest'

class User < ActiveRecord::Base
  include ActiveModel::Dirty

  attr_accessor :password
  attr_accessor :old_password
  define_attribute_methods = [:encrypted_password]

  attr_accessible :name, :photo, :surname, :email, :password, :password_confirmation

  scope :merchant, :conditions => {:role => 'merchant'}


  has_attached_file :photo, 
    :storage => :s3,
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :path => ":attachment/:id/:style/:basename.:extension",
    :bucket => ENV['S3_BUCKET'], # "dealframedevel",
    :s3_protocol => "https",
    :url => ":s3_eu_url",
    :styles => {:medium => "225x225", :thumb => "85x86"}, :default_url => "/images/missing.jpg"
  
  has_many :couppons
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :companies

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  
  validates :password,  :presence => {:if => :password_required?},
                        :confirmation => { :if => :password_required? },
                        :length => { :within => 6..40 , :if => :password_required?}

  #validates_presence_of :password_confirmation

  #validates :name, :presence => true
  #validates :surname, :presence => true
  
  before_save :encrypt_password, :if => :password_required?
  def self.s3_config
    @@s3_config ||= YAML.load(ERB.new(File.read("#{Rails.root}/config/s3.yml")).result)[Rails.env]    
  end
  def change_password(old_password, new_password)
    logger.info("jestem w change_pass")
    logger.info("has pass: #{has_password?(old_password)}")

    logger.info(self.attributes)  
    
    self.password = "#{new_password}"
    save(:validate => true)

    /if has_password?(old_password) 
      self.encrypted_password_will_change!
      logger.info("activemodel has been informed!")
      self.password = "chuj123"
      logger.info("pass set to chuj123")
      save(:validate => true)
    else
      return false
    end
    /
  end

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
 
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  protected
  def password_required?
    self.new_record? || self.encrypted_password_changed?
  end

  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
end
