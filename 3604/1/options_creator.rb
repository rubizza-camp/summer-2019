require 'optparse'

# class for initialization arguments
class OptionsCreator
  def initialize
    @options = {
      top: nil,
      name: nil,
      file: 'gems.yml'
    }
  end

  def hash_options
    @parser = OptionParser.new do |opt|
      opt.on('--top TOP')
      opt.on('--name NAME')
      opt.on('--file FILE')
    end.parse!(into: @options)
    @options
  end
end
