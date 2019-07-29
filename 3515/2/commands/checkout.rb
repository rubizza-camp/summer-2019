require_relative '../helper_modules/helper'

module CheckoutCommand
  include Helper
  def checkout!(*)
    if user_authorized?
      checkin_true?
    else
      respond_with :message, text: I18n.t(:user_is_not_authorized)
    end
  end

  def checkin_true?
    if current_user.checkin == 'true'
      photo_request
    else
      respond_with :message, text: I18n.t(:checkin_first!)
    end
  end

  def photo_request
    respond_with :message, text: I18n.t(:send_me_photo)
    save_context :check_api_photo_file_path
  end

  def check_api_photo_file_path(*)
    if payload.include?('photo')
      respond_with :message, text: I18n.t(:got_a_photo)
      api_photo_file_true(payload)
    else
      respond_with :message, text: I18n.t(:polite_request)
      photo_request
    end
  end

  def api_photo_file_true(payload)
    photo_id = payload['photo'].last['file_id']
    uri = photo_path_uri_method(photo_id)
    photo_path = JSON.parse(Net::HTTP.get(uri))['result']['file_path']
    photo_downloader(photo_path)
  end

  def photo_downloader(photo_path)
    checkout_path = "public/#{from['id']}/checkout/#{Time.now}"
    Helper.dir_maker(checkout_path)
    photo_path_new = "#{checkout_path}/selfie.jpg"
    Helper.file_write(photo_path_new, photo_download_uri_method(photo_path))
    request_geolocation
  end

  def request_geolocation
    respond_with :message, text: I18n.t(:send_me_geolocation)
    save_context :get_geolocation
  end

  def get_geolocation(*)
    if payload.include?('location')
      respond_with :message, text: I18n.t(:got_a_geolocation)
      geolocation = payload['location'].values.to_a
      geolocation_checker(geolocation)
    else
      respond_with :message, text: I18n.t(:polite_request)
      request_geolocation
    end
  end

  def geolocation_checker(geolocation)
    if geolocation.first.between?(53.9145, 53.916) &&
       geolocation.last.between?(27.567, 27.57)

      current_user.set(:checkin, 'false')
      respond_with :photo, photo: File.open('commands/checkout.jpg')
      respond_with :message, text: I18n.t(:goodbye)
    else
      respond_with :message, text: I18n.t(:you_are_not_in_camp)
    end
  end
end
