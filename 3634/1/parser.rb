require_relative 'extractor'

class Parser
  include Extractor
  attr_reader :header, :rows

  def initialize
    @header = []
    @rows = []
  end

  def scrap(links, names, terminal_opts)
    store_data(links, names, terminal_opts)
  end

  private

  def store_data(links, names, terminal_opts)
    one_part = links.map { |link| run(link) }
    second_part = links.map { |link| run("#{link.gsub(%r{/$}, '')}/network/dependents") }
    helper(one_part, second_part, names, terminal_opts)
  end

  def helper(one_part, second_part, names, terminal_opts)
    data = one_part.map.with_index { |hash, item| hash.merge(second_part[item]) }
    data.each_with_index do |value, item|
      @rows << value.values.unshift(item + 1, names[item])
      header_preparation(value) if @header.empty?
    end
    if terminal_opts[:name]
      @rows.select! { |item| item[1][/#{terminal_opts[:name]}/] }
      @rows.map(&:shift).map { |item| item.unshift(@rows.index(item) + 1) }
    end
    top_score(terminal_opts[:top]) if terminal_opts[:top]
  end

  def top_score(num)
    prepared_rows = []
    score = @rows.map { |number| number[2, 8].inject(0) { |sum, item| sum + item.to_i } }
    num.to_i.times { |times| prepared_rows << @rows[score.index(score.sort[-1 - times])] }
    prepared_rows.map(&:shift)
    prepared_rows.map { |item| item.unshift(prepared_rows.index(item) + 1) }
    @rows = prepared_rows
  end

  def header_preparation(value)
    value.each_key { |key| @header << key.to_s.capitalize.tr('_', ' ') }
    @header.unshift(' ', 'Gem')
  end
end
