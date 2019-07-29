require_relative 'file_downloader'
require 'fileutils'
require_relative 'validation'

class NestingSaver
  include Validation::CheckinAssistant
  attr_reader :chat_session, :payload, :session_key

  def initialize(chat_session, session_key, payload)
    @chat_session = chat_session
    @session_key = session_key
    @payload = payload
  end

  def save_files
    make_path
    save :geo
    save :photo
  end

  def make_path
    FileUtils.makedirs path
  end

  def path
    @path ||= "public/#{session_key}/#{check}/#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}"
  end

  def check
    checkin_is_not_required ? 'checkout' : 'checkin'
  end

  def save(type)
    send(type)
  end

  def geo
    FileUtils.touch "#{path}/geolocation.txt"

    File.open(File.expand_path("#{path}/geolocation.txt"), 'w') do |file|
      file.write "#{payload['location']['latitude']}\n"
      file.write payload['location']['longitude']
    end
  end

  def photo
    File.open("#{path}/selfie.jpg", 'wb') do |file|
      file << FileDownloader.new(file_definer).download_file
    end
  end

  def file_definer
    chat_session[session_key]['photo'].last['file_id']
  end
end
