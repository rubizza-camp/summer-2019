class Output
  attr_reader :array_with_info, :top

  def initialize(hash_with_gem_stats, top)
    @gem_hash = hash_with_gem_stats
    @top = top.to_i
  end

  def bigger_element(array_size)
    return @top if array_size > @top && @top != 0
    array_size
  end

  def sort
    @gem_hash = @gem_hash.sort_by { |_key, value| -value[:score] }.to_h
  end

  def print
    sort
    table = Terminal::Table.new
    bigger_element(@gem_hash.size).times do |index|
      table.add_row(GemSerializer.new(@gem_hash.keys[index],
                                      @gem_hash.values[index]).table_row)
    end
    puts table
  end
end
