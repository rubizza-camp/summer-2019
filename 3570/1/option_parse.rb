# frozen_string_literal: true

require 'optparse'

class OptionParse
  DEFAULT_OPTIONS = { top: nil, name: nil, file: 'gems_list.yml' }.freeze

  def parse
    options = {}
    OptionParser.new do |opts|
      console_values(options, opts)
    end.parse!
    DEFAULT_OPTIONS.merge(options)
  end

  private

  # :reek:TooManyStatements
  def console_values(options, opts)
    opts.on('--top=NUM') { |num| options[:top] = num.to_i }
    opts.on('--name=NAME') { |name| options[:name] = name }
    opts.on('--file=PATH') { |file| options[:file] = file }
  end
end
