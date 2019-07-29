# frozen_string_literal: true

class LocationSaver
  def self.perform(location, telegram_id)
    new(location, telegram_id).perform
  end

  attr_reader :location, :telegram_id

  def initialize(location, telegram_id)
    @location = location
    @telegram_id = telegram_id
  end

  def perform
    File.write(location_path, location, mode: 'wb')
    location_path
  end

  private

  def location_path
    File.join(__dir__, person_number, Date.today.to_s, 'geo')
  end

  def person_number
    User.find(telegram_id: telegram_id).first.person_number
  end
end
