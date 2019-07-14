require_relative 'extractor'

class Parser
  attr_reader :data

  def initialize(links, names)
    @data = store_data(links, names)
  end

  include Extractor

  private

  # :reek:TooManyStatements
  def store_data(links, names)
    one_part_data = links.map { |link| run(link) }
    second_part_data = links.map { |link| run("#{link}/network/dependents") }
    data = one_part_data.map.with_index { |hash, item| hash.merge(second_part_data[item]) }
    Hash[names.zip(data)]
  end
end
