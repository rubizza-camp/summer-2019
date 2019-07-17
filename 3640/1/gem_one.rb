require_relative 'scraper.rb'

class GemOne
  attr_reader :name, :parameters
  def initialize(name, parameters)
    @name = name
    @parameters = parameters
  end

  def rating
    @rating ||= @parameters.values.sum
  end
end
