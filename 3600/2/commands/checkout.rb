# frozen_string_literal: true

require_relative '../identifiers'
require_relative '../download'
require 'date'

# :nodoc:
module Checkout
  include Identifiers
  include DownloadHelper
  @long_message = ''
  def checkout!(*)
    shrt_msg = 'You are not registred. Tap /start to register.'
    if registred?
      save_context :photo_checkout
      respond_with :message, text: 'Send your photo'
    else
      respond_with :message, text: shrt_msg
    end
  end

  def photo_checkout(_context = nil, *)
    session[:time] = Time.now.strftime('%d%m%Y-%H%M%S')
    FileUtils.mkdir_p("public/#{user_id}/checkouts/#{session[:time]}")
    download_photo("public/#{user_id}/checkouts/#{session[:time]}/")
    save_context :geo_checkout
    respond_with :message, text: 'Send your geoposition'
  end

  def geo_checkout
    download_geo("public/#{user_id}/checkouts/#{session[:time]}/")
  end
end
