require 'fileutils'
require 'open-uri'

class SaveHelper
  attr_reader :bot, :token

  def initialize(bot, token)
    @bot = bot
    @token = token
  end

  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def save_checkin(data_hash)
    folder_path = create_folder_path(data_hash['camp_id'])
    time = Time.now.strftime('%H:%M-%d-%m-%Y')
    location = " локация: #{data_hash['latitude']}, #{data_hash['longitude']}"
    save_photo(data_hash['selfie'], folder_path, bot)
    file = File.new("#{folder_path}sessions.txt", 'a:UTF-8')
    file.puts("время входа: #{time} #{location}")
    file.close
  end

  # :reek:FeatureEnvy
  def save_checkout(camp_id)
    folder_path = create_folder_path(camp_id)
    time = Time.now.strftime('%H:%M-%d-%m-%Y')
    file = File.new("#{folder_path}sessions.txt", 'a:UTF-8')
    file.puts("время выхода: #{time}")
    file.close
  end

  # :reek:UtilityFunction
  def create_folder_path(camp_id)
    folder_path = " public/#{camp_id}/"
    FileUtils.mkdir_p folder_path
    folder_path
  end

  # :reek:NestedIterators
  def save_photo(photo_id, folder_path)
    file_path = bot.api.get_file(file_id: photo_id)['result']['file_path']
    photo_url = "https://api.telegram.org/file/bot#{token}/#{file_path}"
    Kernel.open(photo_url) do |image|
      File.open("#{folder_path}#{time}.jpg", 'wb') do |file|
        file.write(image.read)
      end
    end
  end
end
