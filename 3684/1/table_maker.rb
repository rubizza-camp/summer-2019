require 'terminal-table'

# :reek:FeatureEnvy
# :reek:NilCheck
# rubocop:disable Metrics/AbcSize
class TableMaker
  attr_reader :gems_info, :flags

  def initialize(gems_info, flags)
    @info = gems_info
    @flags = flags
  end

  def table
    make_top
    build_table
  end

  private

  def make_top
    @info.each do |element|
      element << (element[1].delete(',').to_i * 0.01 + element[4].delete(',').to_i * 0.3).round
    end
    @info.sort! { |first, second| second.last <=> first.last }
    @info.each(&:pop)
  end

  def check_for_a_word
    new_info = []
    @info.each do |element|
      new_info << element if element.first.include?(@flags[:word])
    end
    @info = new_info
  end

  def change_info
    @info = @info.take(@flags[:number].to_i) unless @flags[:number].nil?
    check_for_a_word unless @flags[:word].nil?
  end

  def build_table
    change_info
    table = Terminal::Table.new do |model|
      model.headings = ['gem name', 'used by', 'contributors', 'issues', 'stars', 'watch', 'forks']
      model.rows = @info
    end
    table
  end
end
# rubocop:enable Metrics/AbcSize
