class Output
  def initialize(name, top)
    @name = name if name
    @top = top if top
  end

  def gems(gems)
    ready_gems = gems
    ready_gems = gems.take(@top) if @top && @top <= 0
    ready_gems = ready_gems.select { |gem| gem.dig(1).include?(@name) } if @name

    output_gems(ready_gems)
  end

  private

  def output_gems(ready_gems)
    warn 'no gems' if ready_gems.empty?
    create_table(ready_gems) unless ready_gems.empty?
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
