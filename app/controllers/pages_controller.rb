class PagesController < ApplicationController
  def home
    @controllers = Dir.new("#{RAILS_ROOT}/app/controllers").entries
    @controllers.each do |controller|
      if controller =~ /_controller/
        cont = controller.camelize.gsub(".rb","")
        puts cont
      end
    end
  end
end
