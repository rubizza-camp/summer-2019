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

  def helper(one_part, second_part, names)
    data = one_part.map.with_index { |hash, item| hash.merge(second_part[item]) }
    data.each_with_index do |value, item|
      @rows << value.values.unshift(item + 1, names[item])
      header_preparation(value) if @header.empty?
    end
  end

  def header_preparation(value)
    value.each_key { |key| @header << key.to_s.capitalize.tr('_', ' ') }
    @header.unshift(' ', 'Gem')
  end
end
