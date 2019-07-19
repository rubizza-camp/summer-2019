# frozen_string_literal: true

require 'haversine'
require './helpers/download_helpers'
require 'face_detect'
require 'face_detect/adapter/google'
module Validator
  include DownloadHelpers

  private

  RUBIZZA_MINSK_LOCATION = [53.915451, 27.568789].freeze

  def near_rubizza?
    Haversine.distance(RUBIZZA_MINSK_LOCATION, geo_parse.values).to_kilometers < 0.3
  end

  def validate_number(number)
    valid = numbers.include?(number)
    save_context :register_message unless valid

    valid
  end

  def validate_face_checkin(photo)
    if face?(photo)
      save_context :ask_for_geo_checkin
      respond_with :message, text: 'OK, now send me a location'
    else
      save_context :ask_for_photo_checkin
      respond_with :message, text: 'Send me photo with your face!'
    end
  end

  def validate_geo_checkin(path)
    if near_rubizza?
      download_last_geo(path)
      session[:checkin] = true
      respond_with :message, text: 'OK, go to work now!'
    else
      save_context :ask_for_geo_checkin
      respond_with :message, text: 'You are not allowed to work distantly,'\
                                   'try to send location again!'
    end
  end

  def validate_face_checkout(photo)
    if face?(photo)
      save_context :ask_for_geo_checkout
      respond_with :message, text: 'OK, now send me a location'
    else
      save_context :ask_for_photo_checkout
      respond_with :message, text: 'Send me photo with your face!'
    end
  end

  def validate_geo_checkout(path)
    if near_rubizza?
      download_last_geo(path)
      session[:checkin] = false
      respond_with :message, text: 'OK, go home now!'
    else
      save_context :ask_for_geo_checkout
      respond_with :message, text: 'WERE YОU CHEATING ALL THIS TIME? Try to send location again'
    end
  end

  def face?(input)
    detector = FaceDetect.new(
      file: input,
      adapter: FaceDetect::Adapter::Google
    )
    !detector.run.empty?
  end
end
