require 'optparse'

# class that set options for colsole call
class Options
  def initialize
    @options = {
      top: nil,
      name: nil,
      file: 'gems.yml'
    }
  end

  def options_for_gems
    @option_parser = OptionParser.new do |option|
      option.on('--top TOP')
      option.on('--name NAME')
      option.on('--file FILE')
    end.parse!(into: @options)
    @options
  end
end
