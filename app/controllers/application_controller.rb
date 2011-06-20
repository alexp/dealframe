class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  #before_filter :authenticate if Rails.env.production? 

  protected 
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "beta" && password == "letmein"
    end
  end
end
