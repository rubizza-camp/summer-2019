# frozen_string_literal: true

# Gem info
class GemEntity
  attr_reader :name
  attr_accessor :options
  def initialize(name)
    @name = name
    GetGemInfo.new(self).call
  end

  def rating
    options.values.sum
  end

  def row
    [
      name,
      "used by #{options[:users]}",
      "watched by #{options[:watchers]}",
      "#{options[:stars]} stars",
      "#{options[:forks]} forks",
      "#{options[:contributors]} contributors",
      "#{options[:issues]} issues"
    ]
  end
end
