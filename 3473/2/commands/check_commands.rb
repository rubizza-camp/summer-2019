# frozen_string_literal: true

require './commands/util'
require './commands/downloader'

module CheckCommands
  include Util
  include LoginCommand
  include Downloader

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
      session[:time] = Time.now
      respond_with :message, text: 'Send selfie'
      save_context :getting_selfie
    else
      respond_with :message, text: 'First you need to login'
    end
  end

  def getting_selfie(*)
    if Time.now - session[:time] > 120
      respond_with :message, text: 'You thought too long. Try again'
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
    if Time.now - session[:time] > 90
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
