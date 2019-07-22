require 'fileutils'
require_relative 'parser'

class Saver
  attr_reader :chat_session, :session_key, :payload

  def initialize(chat_session, session_key, payload)
    @chat_session = chat_session
    @session_key = session_key
    @payload = payload
  end

  def save_files
    make_path
    save :geoposition, path
    save :photo, path
  end

  def make_path
    FileUtils.makedirs path
  end

  def path
    @path ||= "public/#{session_key}/#{check}/#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}"
  end

  def check
    chat_session[session_key]['checkin'] ? 'checkout' : 'checkin'
  end

  def save(type, path)
    send(type, path)
  end

  def geoposition(path)
    FileUtils.touch "#{path}/geo.txt"

    File.open(File.expand_path("#{path}/geo.txt"), 'w') do |file|
      file.write "#{payload['location']['latitude']}\n"
      file.write payload['location']['longitude']
    end
  end

  def photo(path)
    File.open("#{path}/selfie.jpg", 'wb') do |file|
      file << Parser.new(chat_session, session_key).download_file
    end
  end
end
