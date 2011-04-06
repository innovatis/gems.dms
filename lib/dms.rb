module DMS
  def self.location
    "http://dms.innovatisinc.ca"
  end 
  
  def self.access_urls(paths, expires_in = 1.hour)
    app_id = Rails.application.config.inno_app_id
    secret = Rails.application.config.inno_app_secret

    repsonse = RestClient.post("#{location}/keys", {
        :paths       => paths, 
        :inno_app_id => app_id,
        :secret      => secret,
        :expires_in  => expires_in})

    response
  end

  def self.access_url(path, expires_in = 1.hour)
    access_urls([path], expires_in).first
  end 

end 
