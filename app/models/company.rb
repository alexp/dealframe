class Company < ActiveRecord::Base
  has_many :offers
  has_many :couppons
end
