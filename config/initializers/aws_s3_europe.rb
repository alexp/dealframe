module AWS
  module S3
    ENDPOINTS = {
      :us     => 's3-us-west-1.amazonaws.com', 
      :asia   => 's3-ap-southeast-1.amazonaws.com', 
      :europe => 's3-eu-west-1.amazonaws.com'
    }

    class Base
      class << self
        def region= region
          endpoint = ENDPOINTS[region] or 
          raise S3Exception, "Unknown region: please use one of #{ENDPOINTS.keys.map(&:inspect).join(', ')}."
          DEFAULT_HOST.replace endpoint
        end
      end
    end
  end
end

AWS::S3::Base.region = :europe
AWS::S3::Base.establish_connection!(
  :access_key_id     => ENV['S3_KEY'] || 'AKIAIXNSHBVXTESY2WAQ',
  :secret_access_key => ENV['S3_SECRET'] || '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'
)
