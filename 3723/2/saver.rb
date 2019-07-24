require 'dotenv/load'

module Saver
  TOKEN = ENV['TOKEN']
  PATH_URL = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze
  PIC_URL = "https://api.telegram.org/file/bot#{TOKEN}/".freeze

  def check_in
    "public/#{payload['from']['id']}/checkins/#{session[:time]}/"
  end

  def check_out
    "public/#{payload['from']['id']}/checkouts/#{session[:time]}/"
  end

  def checkin_time
    session[:time] = Time.now.utc.to_s
    take_pic(check_in_new)
  end

  def checkout_time
    session[:time] = Time.now.utc.to_s
    take_pic(check_out_new)
  end

  def check_in_new
    FileUtils.mkdir_p(check_in) unless File.exist?(check_in)
    check_in
  end

  def check_out_new
    FileUtils.mkdir_p(check_out) unless File.exist?(check_out)
    check_out
  end

  def path_for_pic
    JSON.parse(url_for_pic)['result']['file_path']
  end

  def url_for_pic
    URI.open("#{PATH_URL}#{payload['photo'].last['file_id']}").read
  end

  def take_pic(path)
    File.open(path + 'selfie.jpg', 'wb') do |dir|
      dir << URI.open("#{PIC_URL}#{path_for_pic}").read
    end
  end

  def take_location(path)
    File.open(path + 'geo.txt', 'wb') do |dir|
      dir << payload['location'].inspect
    end
  end
end
