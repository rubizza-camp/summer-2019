require 'fileutils'
require 'time'
require_relative '../helpers/location_helper.rb'
require_relative '../helpers/photo_helper.rb'
require_relative '../helpers/user_helper.rb'

# module with checkout command
module CheckoutCommand
  include PhotoHelper
  include LocationHelper

  TIME = Time.now.strftime('%a, %d %b %Y %H:%M')

  def checkout!(*)
    if UserHelper.registered(from['id']) && User[from['id']].in_camp == 'true'
      checkin_photo
      User[from['id']].update in_camp: 'false'
    else
      respond_with :message, text: 'U\'re not in camp'
    end
  end

  def checkout_photo(*)
    if payload['photo']
      save_checkin_photo
      checkin_location
    else
      save_context :checkin_photo
      respond_with :message, text: 'Send yourself!'
    end
  end

  def checkout_location(*)
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

  def save_checkout_photo(*)
    path = photo_path
    create_directory(from['id'])
    File.open(path(from['id']) + '/photo.jpg', 'wb') do |file|
      file << URI.open(DOWNLOAD_API + path).read
    end
  end

  def save_checkout_location(*)
    path = path(from['id']) + '/location.txt'
    File.open(path, 'wb') do |file|
      file << payload['location'].values
    end
  end

  def create_directory(id)
    FileUtils.mkdir_p(path(id))
  end

  def path(id)
    "public/#{id}/checkout/#{TIME}"
  end
end
