class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :save_referer
  #before_filter :authenticate if Rails.env.production? 
  @categories = Category.all
  protected 
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "beta" && password == "letmein"
    end
  end

  def save_referer
    unless signed_in? 
      unless 
        session['referer'] = request.env['HTTP_REFERER'] || 'none'
      end
    end
  end
end
