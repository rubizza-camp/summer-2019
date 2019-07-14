require 'terminal-table'
# :reek:FeatureEnvy
# :reek:TooManyStatements
# rubocop:disable Metrics/AbcSize
# class about output info
class FillOutput
  def initialize(array_with_info, top)
    @array_with_info = array_with_info
    best_gem
    top_option(top) unless top.zero?
    add_text_to_number
    table = Terminal::Table.new rows: @array_with_info.reverse!
    puts table
  end

  def top_option(top)
    0.upto(@array_with_info.size - top - 1) { @array_with_info.shift }
  end

  def best_gem
    @array_with_info.sort_by! do |element|
      element[1] * 0.5 + element[2] * 1 + element[3] * 0.7 + element[6] * 0.5 +
        element[4] * 0.5 + element[5] * 0.5
    end
  end

  def add_text_to_number
    @array_with_info.each do |element|
      element[1] = "watched by #{element[1]}"
      element[2] = "#{element[2]} stars"
      element[3] = "#{element[3]} forks"
      element[4] = "#{element[4]} contributors"
      element[5] = "#{element[5]} issues"
      element[6] = "used by #{element[6]}"
    end
  end
end
# rubocop:enable Metrics/AbcSize
