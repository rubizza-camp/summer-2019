# This class parse option parameters

class OptionParse
  attr_reader :options

  def initialize
    @options = {}
    @parser = OptionParser.new
  end

  def call
    call_parser
    options
  end

  def self.call
    new.call
  end

  private

  def call_parser
    OptionParser.new do |opts|
      bind_flag(opts, '--file=', :file)
      bind_flag(opts, '--top=', :top)
      bind_flag(opts, '--name=', :name)
    end.parse!
  end

  def bind_flag(opts, flag, sym)
    opts.on(flag, '') { |value| options[sym] = value }
  end
end
