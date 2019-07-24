# frozen_string_literal: true

class LoaderPhoto
  include Helper

  attr_reader :payload, :time, :status

  def initialize(payload, time, status)
    @payload = payload
    @time = time
    @status = status
  end

  def self.call(payload, time, status)
    new(payload, time, status).call
  end

  def call
    download_last_photo(create_checkin_path)
    { status: true, message: GEOLOCATION }
  rescue NoMethodError
    { status: false, message: NOT_PHOTO }
  end

  private

  def download_last_photo(local_path)
    File.open(local_path + 'selfie.jpg', 'w') do |file|
      file << URI.open(API_URL_TELEGRAM_FILE + photo_file_path).read
    end
  end

  def create_checkin_path
    local_path = "./private/#{student_number}/#{status}/#{time}/"
    FileUtils.mkdir_p(local_path) unless File.exist?(local_path)
    local_path
  end

  def photo_file_path
    JSON.parse(URI.open(url_json_about_file).read, symbolize_names: true).dig(:result, :file_path)
  end

  def url_json_about_file
    @url_json_about_file ||= API_URL_TELEGRAM + GET_FILE_URL + payload['photo'].last['file_id']
  end
end
