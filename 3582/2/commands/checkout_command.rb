require 'date'
require 'fileutils'
require './modules/fetch_messages'
module CheckoutCommand
  include FetchMessages
  def checkout!(*)
    if checkined?
      save_context :download_photo_checkout
      respond_with :message, text: 'Пришли своё фото'
    elsif !session[:checkined] && session[:is_registered]
      respond_with :message, text: "Открой смену, #{session[:group_id]}"
    else
      respond_with :message, text: 'Нет доступа к этой команде'
    end
  end

  def download_photo_checkout
    @path = "./public/#{session_key}/checkouts/#{Date.today.strftime}/"
    FileUtils.mkdir_p @path
    File.write([@path, 'photo.jpg'].join, Net::HTTP.get(fetch_photo_uri))
    save_context :download_location_checkout
    respond_with :message, text: 'Пришли мне своё местоположение'
  end

  def download_location_checkout
    @path = "./public/#{session_key}/checkouts/#{Date.today.strftime}/"
    File.write([@path, 'location.txt'].join, fetch_location)
    session[:checkined] = false
    respond_with :message, text: 'Смена закрыта'
  end

  private

  def checkined?
    session[:checkined] && session[:is_registered]
  end
end
