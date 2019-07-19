require_relative 'extractor'

class DataBuilder
  include Extractor
  attr_reader :header, :rows

  def initialize
    @header = []
    @rows = []
    @rows_helper = []
    @data = []
  end

  def construct(links, names, input)
    store_data_in_hash(links)
    store_data_in_array(names, input)
    user_demands_data_prepare(input) if input[:name] || input[:top]
  end

  private

  def store_data_in_hash(links)
    one_part_data = links.map { |link| run(link) }
    second_part_data = links.map { |link| run("#{link.gsub(%r{/$}, '')}/network/dependents") }
    helper(one_part_data, second_part_data)
  end

  def helper(one, two)
    @data = two.map.with_index { |hash, item| hash.merge(one[item]) }
  end

  def store_data_in_array(names, _input)
    @data.each_with_index do |value, item|
      @rows << value.values.unshift(item + 1, names[item])
      header_builder(value) if @header.empty?
    end
  end

  def user_demands_data_prepare(input)
    @rows.select! { |item| item[1][/#{input[:name]}/] }
    @rows = add_number_to_row(@rows) if input[:name]
    top_score_builder(input[:top]) if input[:top]
  end

  def top_score_builder(user_num)
    score = @rows.map { |number| number[2, 8] }.map(&:sum)
    user_num.to_i.times { |times| @rows_helper << @rows[score.index(score.sort[-1 - times])] }
    @rows = add_number_to_row(@rows_helper)
  end

  def add_number_to_row(rows)
    rows.map(&:shift)
    rows.map { |item| item.unshift(rows.index(item) + 1) }
  end

  def header_builder(value)
    value.each_key { |key| @header << key.to_s.capitalize.tr('_', ' ') }
    @header.unshift(' ', 'Gem')
  end
end
