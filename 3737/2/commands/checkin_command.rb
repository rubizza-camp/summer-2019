require 'fileutils'
require 'haversine'
require 'time'
require_relative '../helpers/photo_helper.rb'
require_relative '../helpers/location_helper.rb'

# module with checkout command
module CheckinCommand
  def checkin!(*)
    if User.registered?(from['id'])
      check_user_state
    else
      respond_with :message, text: 'You\'re not registered'
    end
  end

  def check_user_state
    if User[from['id']].in_camp == 'false'
      session[:time] = Time.now.strftime('%a, %d %b %Y %H:%M')
      checkin_photo
    else
      respond_with :message, text: 'You\'re in camp'
    end
  end

  def checkin_photo(*)
    if payload['photo']
      save_checkin_photo
    else
      save_context :checkin_photo
      respond_with :message, text: 'Send yourself!'
    end
  end

  def checkin_location(*)
    if payload['location'] && LocationHelper.valid_location(payload['location'].values)
      respond_with :message, text: 'Cool! Good luck!'
      save_checkin_location
    else
      save_context :checkin_location
      respond_with :message, text: 'Send your location'
    end
  end

  private

  def save_checkin_photo(*)
    checkin_location
    create_checkin_directory(from['id'])
    save_photo(checkin_path(from['id']))
  end

  def save_checkin_location(*)
    path = checkin_path(from['id']) + '/location.txt'
    File.open(path, 'wb') do |file|
      file << payload['location'].values
    end
    User[from['id']].update(in_camp: 'true')
  end

  def create_checkin_directory(id)
    FileUtils.mkdir_p(checkin_path(id))
  end

  def checkin_path(id)
    "public/#{id}/checkin/#{session[:time]}"
  end
end
