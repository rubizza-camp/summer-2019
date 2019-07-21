require 'optparse'

class OptionController
  def self.options
    load_options
  end

  def self.load_options
    options = {}
    OptionParser.new do |opts|
      opts.on('--bot_token[=OPTIONAL]', String, 'bot token string')
    end.parse!(into: options)
    options
  end
end
