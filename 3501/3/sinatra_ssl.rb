require 'webrick/ssl'

module Sinatra
  class Application
    def self.run!
      Rack::Handler::WEBrick.run(self, open_ssl_cert) do |server|
        func_next(server)
      end
    end

    def func_next(server)
      %i[INT TERM].each do |sig|
        trap(sig) do
          server.stop
        end
      end
      server.threaded = settings.threaded
      set :running, true
    end

    def open_ssl_cert
      certificate_content = File.open(ssl_certificate).read
      key_content = File.open(ssl_key).read
      server_options = {
        Host: bind,
        Port: port,
        SSLEnable: true,
        SSLCertificate: OpenSSL::X509::Certificate.new(certificate_content),
        SSLPrivateKey: OpenSSL::PKey::RSA.new(key_content)
      }
      server_options
    end
  end
end
