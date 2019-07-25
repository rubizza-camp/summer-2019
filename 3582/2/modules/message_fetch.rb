require 'net/http'
require 'httparty'
require 'pry'
module MessageFetch
  def fetch_photo_uri
    json = HTTParty.get("https://api.telegram.org/bot#{TOKEN}/getupdates")
    file_id = json['result'][-1]['message']['photo'][-1]['file_id']
    file_path = HTTParty.get("https://api.telegram.org/bot#{TOKEN}/getfile?file_id=#{file_id}")
    file_path = file_path['result']['file_path']
    @photo_uri = URI.parse("https://api.telegram.org/file/bot#{TOKEN}/#{file_path}")
  end

  def fetch_location
    json = HTTParty.get("https://api.telegram.org/bot#{TOKEN}/getupdates")
    geo = json['result'][-1]['message']['location']
    @lat = geo['latitude']
    @long = geo['longitude']
    [@lat, @long]
  end
end
