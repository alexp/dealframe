class Company < ActiveRecord::Base
  has_many :offers
  has_many :couppons

  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower 
end
