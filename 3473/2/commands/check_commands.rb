# frozen_string_literal: true

require_relative './util'
require_relative './downloader'

module CheckCommands
  include Util
  include LoginCommand
  include Downloader

  TIME_TO_GET_SELFIE = 60
  TIME_TO_SEND_GEO = 90

  def checkin!(*)
    if session[:state] == :in
      respond_with :message, text: 'First you need to checkout'
      return
    end
    session[:check] = :in
    check
  end

  def checkout!(*)
    if session[:state] == :out
      respond_with :message, text: 'First you need to checkin'
      return
    end
    session[:check] = :out
    check
  end

  def check
    if registered?
      session[:time] = Time.now.utc.to_i
      respond_with :message, text: 'Send selfie'
      save_context :getting_selfie
    else
      respond_with :message, text: 'First you need to login'
    end
  end

  def getting_selfie(*)
    if Time.now.utc.to_i - session[:time] > TIME_TO_GET_SELFIE
      respond_with :message, text: "You thought too long. Try to check#{session[:check]} again"
    else
      save_selfie
    end
  rescue Telegram::Bot::Error => err
    rescue_download(err, :getting_selfie)
  end

  def save_selfie
    download_photo
    respond_with :message, text: 'Send geolocation'
    save_context :getting_geo
  end

  def getting_geo(*)
    if Time.now.utc.to_i - session[:time] > TIME_TO_SEND_GEO + TIME_TO_GET_SELFIE
      respond_with :message, text: "You thought too long. Try to check#{session[:check]} again"
    else
      save_geo
    end
  rescue Telegram::Bot::Error => err
    rescue_download(err, :getting_geo)
  end

  def save_geo
    download_location
    session[:state] = session[:check]
    respond_with :message, text: checked_message
  end

  def checked_message
    'You\'ve checked ' + (session[:state] == :in ? 'in. Work hard' : 'out. Relax')
  end

  def rescue_download(err, context)
    respond_with :message, text: err.message
    save_context context
  end
end
