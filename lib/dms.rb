require 'json'

module Dms

  class Engine < ::Rails::Engine
  end
  
  def self.location
    if Rails.env.development?
      "http://dms.dev"
    else
      "http://dms.innovatisinc.ca"
    end
  end
  
  def self.url_for_private(path, expires_in = 1.hour)
    RestClient.post("#{location}/keys", {
        :path => path,
        :secret => Rails.application.config.dms_secret,
        :expires_in => expires_in})
  end

  def self.access_urls(paths, expires_in = 1.hour)
    app_id = Rails.application.config.inno_app_id
    secret = Rails.application.config.inno_app_secret

    response = RestClient.post("#{location}/keys", {
        :paths       => paths, 
        :inno_app_id => app_id,
        :secret      => secret,
        :expires_in  => expires_in})

    JSON.parse(response)
  end

  def self.access_url(path, expires_in = 1.hour)
    access_urls([path], expires_in).first
  end 

end 
