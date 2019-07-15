require_relative 'extractor'

class Parser
  include Extractor
  attr_reader :header, :rows

  def initialize
    @header = []
    @rows = []
  end

  def scrap(links, names)
    store_data(links, names)
  end

  private

  def store_data(links, names)
    one_part = links.map { |link| run(link) }
    second_part = links.map { |link| run("#{link.gsub(%r{/$}, '')}/network/dependents") }
    helper(one_part, second_part, names)
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # :reek:NestedIterators
  # :reek:TooManyStatements
  def helper(one_part, second_part, names)
    data = one_part.map.with_index { |hash, item| hash.merge(second_part[item]) }
    data.each_with_index do |value, item|
      row = []
      value.each_value { |gem_data| row << gem_data }
      row.unshift(names[item])
      row.unshift(item + 1)
      @rows << row
      if @header.empty?
        value.each_key { |key| @header << key.to_s.capitalize.gsub(/_/, ' ') }
        @header.unshift(' ', 'Gem')
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
