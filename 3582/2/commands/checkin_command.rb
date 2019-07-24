require 'date'
require 'fileutils'
require './modules/fetch_messages'
module CheckinCommand
  include FetchMessages
  def checkin!(*)
    if session[:checkined]
      respond_with :message, text: 'Смена уже началась'
    elsif session[:is_registered]
      save_context :download_photo_checkin
      respond_with :message, text: 'Пришли мне своё фото'
    else
      respond_with :message, text: 'Нет доступа к этой команде'
    end
  end

  def download_photo_checkin
    @path = "./public/#{session_key}/checkins/#{Date.today.strftime}/"
    FileUtils.mkdir_p @path
    File.write([@path, 'photo.jpg'].join, Net::HTTP.get(fetch_photo_uri))
    save_context :download_location_checkin
    respond_with :message, text: 'Пришли мне своё местоположение'
  end

  def download_location_checkin
    @path = "./public/#{session_key}/checkins/#{Date.today.strftime}/"
    File.write([@path, 'location.txt'].join, fetch_location)
    session[:checkined] = true
    respond_with :message, text: 'Смена началась)'
  end
end
