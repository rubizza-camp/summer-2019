# frozen_string_literal: true

require './gem'

# Implemeting Factory Pattern
class GemFactory
  def self.build(gem_name)
    Gemi.new(gem_name)
  end
end
