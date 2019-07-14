require_relative 'scraper.rb'

# Class Gem
class Geme
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def parameters
    @parameters ||= Scraper.gem_get_parameters(@name)
  end

  def rating
    @rating ||= parameters.values.sum
  end
end
