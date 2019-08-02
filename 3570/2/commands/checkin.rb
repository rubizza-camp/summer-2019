# frozen_string_literal: true

require_relative '../helpers/file_helper'

module CheckinCommand
  include FileHelper

  def checkin!(*)
    if session.key?(:cadet_id)
      session[:timestamp] = Time.now.to_s
      save_context :receive_checkin_photo
      respond_with :message, text: 'Сделай и отправь селфи'
    else
      respond_with :message, text: 'Ты не авторизирован'
    end
  end

  def receive_checkin_photo(*)
    save_photo(checkin_directory)
    save_context :recieve_checkin_location
    respond_with :message, text: 'Пришли свою геолокацию'
  end

  def recieve_checkin_location(*)
    if validate_location
      save_location(checkin_directory)
      respond_with :message, text: 'Отлично, ты на месте. Можешь приступать'
    else
      respond_with :message, text: 'Ты еще не в кемпе...поторопись'
    end
  end

  private

  def user_id
    payload['from']['id']
  end

  def checkin_directory_path
    "public/#{user_id}/checkins/#{session[:timestamp]}/"
  end

  def checkin_directory
    FileUtils.mkdir_p(checkin_directory_path) unless File.exist?(checkin_directory_path)
    checkin_directory_path
  end
end
