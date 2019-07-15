require 'terminal-table'

class Output
  def initialize(name_filter, top)
    @name_filter = name_filter || ''
    @top = top&.positive? ? top : nil
  end

  def gems(gems)
    ready_gems = gems[0...@top]
    ready_gems = ready_gems.select { |gem| gem.dig(1).include?(@name_filter) }

    output_gems(ready_gems)
  end

  private

  def output_gems(ready_gems)
    if ready_gems.empty?
      warn 'no gems'
    else
      create_table(ready_gems)
    end
  end

  def create_table(ready_gems)
    table = Terminal::Table.new do |t|
      ready_gems.each do |gem|
        gem_stats = gem[2].stats
        gem_name = gem[1]
        t.add_row content(gem_name, gem_stats)
      end
    end
    puts ''
    puts table
  end

  def content(name, stats)
    [
      name, "used by #{stats[:used_by]}",
      "watched by #{stats[:watched_by]}", "#{stats[:stars]} stars",
      "#{stats[:forks]} forks", "#{stats[:contributors]} contributors",
      "#{stats[:issues]} issues"
    ]
  end
end
