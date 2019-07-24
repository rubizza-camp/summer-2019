require 'fileutils'
require './validations/validations'
require_relative 'downloader'

class Save
  include Validations::Helper

  attr_reader :chat_session, :session_key, :payload

  def initialize(chat_session, session_key, payload)
    @chat_session = chat_session
    @session_key = session_key
    @payload = payload
  end

  def save_files
    fetch_path
    save :geoposition
    save :photo
  end

  private

  def fetch_path
    FileUtils.makedirs path
  end

  def path
    @path ||= "public/#{session_key}/#{check_folder}/#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}"
  end

  def check_folder
    checkin? ? 'checkout' : 'checkin'
  end

  def save(type)
    send(type)
  end

  def geoposition
    FileUtils.touch "#{path}/geo.txt"

    File.open(File.expand_path("#{path}/geo.txt"), 'w') do |file|
      file.write "#{payload['location']['latitude']}\n"
      file.write payload['location']['longitude']
    end
  end

  def photo
    File.open("#{path}/selfie.jpg", 'wb') do |file|
      file << Downloader.new(file_identifier).download_file
    end
  end

  def file_identifier
    chat_session[session_key]['photo'].last['file_id']
  end
end
