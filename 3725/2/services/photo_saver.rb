# frozen_string_literal: true

class PhotoSaver
  API_URL = 'https://api.telegram.org/'

  def self.perform(file_id, telegram_id)
    new(file_id, telegram_id).perform
  end

  attr_reader :file_id, :telegram_id

  def initialize(file_id, telegram_id)
    @file_id = file_id
    @telegram_id = telegram_id
  end

  def perform
    create_destination_dir
    File.write(photo_filename, Kernel.open(photo_url).read, mode: 'wb')
    photo_filename
  end

  private

  def photo_filename
    File.join(destination_dir, 'photo.jpg')
  end

  def create_destination_dir
    FileUtils.mkdir_p(destination_dir)
  end

  def destination_dir
    File.join(__dir__, person_number, Date.today.to_s)
  end

  def photo_url
    URI("#{ENV['API_URL']}bot#{ENV['KEY_TOKEN']}/getFile?file_id=#{file_id}")
  end

  def photo_path
    photo_meta.dig('result', 'file_path')
  end

  def photo_meta
    JSON.parse(Net::HTTP.get(url))
  end

  def url
    URI(url_string.concat('?', url_params))
  end

  def url_string
    File.join(ENV['API_URL'], "bot#{ENV['KEY_TOKEN']}", 'getFile').to_s
  end

  def url_params
    URI.encode_www_form(file_id: file_id)
  end

  def person_number
    User.find(telegram_id: telegram_id).first.person_number
  end
end
