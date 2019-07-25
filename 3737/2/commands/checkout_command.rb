require 'fileutils'
require 'haversine'
require 'time'
require_relative '../helpers/photo_helper.rb'
require_relative '../helpers/location_helper.rb'

# module with checkout command
module CheckoutCommand
  def checkout!(*)
    if User.registered?(from['id'])
      check_user_state
    else
      respond_with :message, text: 'You\'re not registered'
    end
  end

  def check_user_state
    if User[from['id']].in_camp == 'true'
      session[:time] = Time.now.strftime('%a, %d %b %Y %H:%M')
      checkin_photo
    else
      respond_with :message, text: 'You\'re not in camp'
    end
  end

  def checkout_photo(*)
    if payload['photo']
      save_checkout_photo
    else
      save_context :checkout_photo
      respond_with :message, text: 'Send yourself!'
    end
  end

  def checkout_location(*)
    if payload['location'] && LocationHelper.valid_location(payload['location'].values)
      respond_with :message, text: 'Cool! Good luck!'
      save_checkout_location
    else
      save_context :checkout_location
      respond_with :message, text: 'Send your location'
    end
  end

  private

  def save_checkout_photo(*)
    checkout_location
    create_checkout_directory(from['id'])
    save_photo(checkout_path(from['id']))
  end

  def save_checkout_location(*)
    path = checkout_path(from['id']) + '/location.txt'
    File.open(path, 'wb') do |file|
      file << payload['location'].values
    end
    User[from['id']].update(in_camp: 'false')
  end

  def create_checkout_directory(id)
    FileUtils.mkdir_p(checkout_path(id))
  end

  def checkout_path(id)
    "public/#{id}/checkout/#{session[:time]}"
  end
end
