# frozen_string_literal: true

require 'haversine'
require 'face_detect'
require 'face_detect/adapter/google'
require_relative 'geo_helpers'
require_relative 'photo_helpers'

module Validator
  include GeoHelpers
  include PhotoHelpers

  private

  RUBIZZA_MINSK_LOCATION = [53.915451, 27.568789].freeze
  MAX_DISTANCE_FROM_CAMP = 0.3

  def near_rubizza?
    Haversine.distance(RUBIZZA_MINSK_LOCATION, geo_parse.values)
             .to_kilometers < MAX_DISTANCE_FROM_CAMP
  end

  def validate_number(number)
    valid = numbers.include?(number)
    save_context :register_message unless valid

    valid
  end

  def validate_face(photo)
    if face?(photo)
      save_context :ask_for_geo
      respond_with :message, text: 'OK, now send me a location'
    else
      save_context :ask_for_photo
      respond_with :message, text: 'Send me photo with your face!'
    end
  end

  def validate_geo(path)
    if near_rubizza?
      download_last_geo(path)
      session[:checkin] = path.include?('checkin')
      respond_with :message, text: 'OK, you can go now'
    else
      save_context :ask_for_geo
      respond_with :message, text: 'You are not allowed to work distantly,'\
                                   'try to send location again!'
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
