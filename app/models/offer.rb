class Offer < ActiveRecord::Base
  belongs_to :category
  belongs_to :company
  
  acts_as_taggable

  def is_active?
    (self.end_date >= Time.now) and (self.status == "active")
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

end
