# Class for showing gems stats
class StatsOutput
  def initialize(word, top)
    @word = word.to_s
    @top = top.to_s
    @final_stats = []
  end

  def show_output(data)
    @final_stats = data
    sort_by_word unless @word.empty?
    sort_by_top unless @top.empty?
    puts Terminal::Table.new headings: ['Gem', 'Used by', 'Watched by', 'Stars', 'Forks',
                                        'Contributors', 'Issues'], rows: @final_stats
  end

  private

  def sort_by_word
    name_array = []
    @final_stats.each do |gem_stats|
      name_array << gem_stats if gem_stats[0].include? @word
    end
    @final_stats = name_array
  end

  def sort_by_top
    top_array = []
    (0..@top.to_i - 1).each do |element|
      top_array << @final_stats[element]
    end
    @final_stats = top_array
  end
end
