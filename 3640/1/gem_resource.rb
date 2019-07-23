require_relative 'scraper.rb'

class GemResource
  attr_reader :name, :parameters
  def initialize(name, parameters)
    @name = name
    @parameters = parameters
  end

  def rating
    @rating ||= @parameters.values.sum
  end

  def to_row
    gem_row_output = ['used_by %<used_by>s',
                      'watched by %<watch>s',
                      '%<star>s stars',
                      '%<forks>s forks',
                      '%<contributors>s contributors',
                      '%<issues>s issues']
    gem_row_output.map { |parameter| format(parameter, @parameters) }.unshift(@name)
  end
end
