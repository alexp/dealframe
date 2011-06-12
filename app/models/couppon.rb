class Couppon < ActiveRecord::Base
  belongs_to :company
  belongs_to :user
  belongs_to :offer


  def generate_security_code(length)
    return ActiveSupport::SecureRandom.hex(length)
  end
end
