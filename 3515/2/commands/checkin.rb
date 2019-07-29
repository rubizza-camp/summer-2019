require_relative '../helper_modules/helper'

module CheckinCommand
  include Helper
  def checkin!(*)
    if user_authorized?
      checkin_false?
    else
      respond_with :message, text: I18n.t(:user_is_not_authorized)
    end
  end

  def checkin_false?
    if current_user.checkin == 'false'
      photo_request_for_checkin
    else
      respond_with :message, text: I18n.t(:already_checkined)
    end
  end

  def photo_request_for_checkin
    respond_with :message, text: I18n.t(:send_me_photo)
    save_context :check_api_photo_file_path_for_checkin
  end

  def check_api_photo_file_path_for_checkin(*)
    if payload.include?('photo')
      respond_with :message, text: I18n.t(:got_a_photo)
      api_photo_file_true_for_checkin(payload)
    else
      respond_with :message, text: I18n.t(:polite_request)
      photo_request_for_checkin
    end
  end

  def api_photo_file_true_for_checkin(payload)
    photo_id = payload['photo'].last['file_id']
    uri = photo_path_uri_method(photo_id)
    photo_path = JSON.parse(Net::HTTP.get(uri))['result']['file_path']
    photo_downloader_for_checkin(photo_path)
  end

  def photo_downloader_for_checkin(photo_path)
    checkin_path = "public/#{from['id']}/checkin/#{Time.now}"
    Helper.dir_maker(checkin_path)
    photo_path_new = "#{checkin_path}/selfie.jpg"
    Helper.file_write(photo_path_new, photo_download_uri_method(photo_path))
    request_geolocation_for_checkin
  end

  def request_geolocation_for_checkin
    respond_with :message, text: I18n.t(:send_me_geolocation)
    save_context :get_geolocation_for_checkin
  end

  def get_geolocation_for_checkin(*)
    if payload.include?('location')
      respond_with :message, text: I18n.t(:got_a_geolocation)
      geolocation = payload['location'].values.to_a
      geolocation_checker_for_checkin(geolocation)
    else
      respond_with :message, text: I18n.t(:polite_request)
      request_geolocation_for_checkin
    end
  end

  def geolocation_checker_for_checkin(geolocation)
    if geolocation.first.between?(53.9145, 53.916) &&
       geolocation.last.between?(27.567, 27.57)

      current_user.set(:checkin, 'true')
      respond_with :photo, photo: File.open('commands/checkin.jpg')
      respond_with :message, text: I18n.t(:success_checkin)
    else
      respond_with :message, text: I18n.t(:you_are_not_in_camp)
    end
  end
end
