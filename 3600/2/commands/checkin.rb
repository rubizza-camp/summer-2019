# frozen_string_literal: true

require_relative '../identifiers'
require_relative '../download'
require 'date'

# :nodoc:
module Checkin
  include Identifiers
  include DownloadHelper
  def checkin!(*)
    shrt_msg = 'You are not registred. Tap /start to register. Then tap /checkin'
    if registred?
      save_context :photo_checkin
      respond_with :message, text: 'Send your photo'
    else
      respond_with :message, text: shrt_msg
    end
  end

  def photo_checkin(_context = nil, *)
    session[:time] = Time.now.strftime('%d%m%Y-%H%M%S')
    FileUtils.mkdir_p("public/#{user_id}/checkins/#{session[:time]}")
    download_photo("public/#{user_id}/checkins/#{session[:time]}/")
    save_context :geo_checkin
    respond_with :message, text: 'Send your geoposition'
  end

  def geo_checkin
    download_geo("public/#{user_id}/checkins/#{session[:time]}/")
  end
end
