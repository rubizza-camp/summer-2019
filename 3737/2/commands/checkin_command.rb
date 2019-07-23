require 'fileutils'
require 'time'
require_relative '../helpers/location_helper.rb'
require_relative '../helpers/photo_helper.rb'
require_relative '../helpers/user_helper.rb'

# module with checkout command
module CheckinCommand
  include PhotoHelper
  include LocationHelper

  TIME = Time.now.strftime('%a, %d %b %Y %H:%M')

  def checkin!(*)
    if UserHelper.registered(from['id']) && User[from['id']].in_camp == 'false'
      checkin_photo
      User[from['id']].update in_camp: 'true'
    else
      respond_with :message, text: 'U\'re in camp'
    end
  end

  def checkin_photo(*)
    if payload['photo']
      save_checkin_photo
      checkin_location
    else
      save_context :checkin_photo
      respond_with :message, text: 'Send yourself!'
    end
  end

  def checkin_location(*)
    if payload['location']
      if valid_location(payload['location'].values)
        respond_with :message, text: 'Cool! Good luck!'
        save_checkin_location
      else
        respond_with :message, text: 'U\' so far from camp! Try later'
      end
    else
      save_context :checkin_location
      respond_with :message, text: 'Send ur location'
    end
  end

  def save_checkin_photo(*)
    path = photo_path
    create_in_directory(from['id'])
    File.open(checkin_path(from['id']) + '/photo.jpg', 'wb') do |file|
      file << URI.open(DOWNLOAD_API + path).read
    end
  end

  def save_checkin_location(*)
    path = checkin_path(from['id']) + '/location.txt'
    File.open(path, 'wb') do |file|
      file << payload['location'].values
    end
  end

  def create_in_directory(id)
    FileUtils.mkdir_p(checkin_path(id))
  end

  def checkin_path(id)
    "public/#{id}/checkin/#{TIME}"
  end
end
