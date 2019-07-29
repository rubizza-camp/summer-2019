# frozen_string_literal: true

require './db/connection'
require './app/lib/snack_bar'
require './app/lib/feed_back'
require './app/lib/user'
require './app/controllers/application_controller'
require './app/controllers/sign_controller'
require './app/controllers/snackbar_controller'
require 'sinatra/base'
require 'sinatra/cookies'
require 'time'
require 'date'
require 'active_record'
require 'sqlite3'

require 'webrick'
require 'webrick/https'
require 'openssl'

CERT_PATH = 'keys/'

webrick_options = {
  # '192.168.43.176' /BANDR
  # '192.168.0.105'
  Host: '192.168.43.176',
  Port: 443,
  Logger: WEBrick::Log.new($stderr, WEBrick::Log::DEBUG),
  DocumentRoot: '/ruby/htdocs',
  SSLEnable: true,
  SSLVerifyClient: OpenSSL::SSL::VERIFY_NONE,
  SSLCertificate: OpenSSL::X509::Certificate.new(File.open(File.join(CERT_PATH, 'cert.crt')).read),
  SSLPrivateKey: OpenSSL::PKey::RSA.new(File.open(File.join(CERT_PATH, 'private.key')).read),
  SSLCertName: [['CN', WEBrick::Utils.getservername]]
}

class MyServer < Sinatra::Base
  set :public_folder, File.dirname(__FILE__) + '/public'

  use ApplicationController
  use SignController
  use SnackBarController
end

Rack::Handler::WEBrick.run MyServer, webrick_options
