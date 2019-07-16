require 'optparse'

# class for initialization arguments
class OptionsCreator
  def initialize
    @options = {
      top: nil,
      name: nil,
      file: 'gems.yml'
    }

    @parser = OptionParser.new do |opt|
      opt.on('--top TOP')
      opt.on('--name NAME')
      opt.on('--file FILE')
    end.parse!(into: hash_options)
  end

  def hash_options
    @options[:top]
    @options[:name]
    @options[:file]
    @options
  end
end
