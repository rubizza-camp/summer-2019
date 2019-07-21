require 'optparse'

class OptionController
  class << self
    def options
      load_options
    end

    def load_options
      options = {}
      OptionParser.new do |opts|
        opts.on('--bot_token[=OPTIONAL]', String, 'bot token string')
      end.parse!(into: options)
      options
    end
  end
end
