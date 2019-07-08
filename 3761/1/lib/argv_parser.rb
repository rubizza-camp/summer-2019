require 'yaml'

class ArgvParser
  FILE_DEFAULT = '.top-gems.yml'.freeze

  attr_reader :args

  def self.call
    new.call
  end

  def call
    parse_args
    check_arg
    args
  end

  private

  def parse_args
    @args = ARGV.map do |arg|
      name, value = arg.split('=')
      [name.delete_prefix('--').to_sym, value]
    end.to_h
  end

  def check_arg
    args[:file] ||= FILE_DEFAULT
    args[:top] = args[:top].to_i if args.key? :top
    args[:name] ||= ''
  end
end
