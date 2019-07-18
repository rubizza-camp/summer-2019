# frozen_string_literal: true

# Gem info
class GemEntity
  attr_reader :name, :options

  def initialize(name)
    @name = name
    @options = GetGemInfo.new(self).call
  end

  def rating
    options[:users] / 100 + options[:watchers] * 2 + options[:stars] * 2 + options[:forks] * 3 +
      options[:contributors] * 5 - options[:issues] * 4 - options[:closed_issues]
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
