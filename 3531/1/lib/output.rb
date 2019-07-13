class Output
  def initialize(params)
    @name = params[:name] if params[:name]
    @top = params[:top] if params[:top]
  end

  def gems(gems)
    ready_gems = gems
    ready_gems = gems.take(@top) if @top
    ready_gems = ready_gems.select { |gem| gem.dig(1).include?(@name) } if @name

    outputs_gems(ready_gems)
  end

  private

  def outputs_gems(ready_gems)
    warn 'no gems' if ready_gems.empty?
    create_table(ready_gems) unless ready_gems.empty?
  end

  def create_table(ready_gems)
    table = Terminal::Table.new do |t|
      ready_gems.each do |gem|
        gem_stats = gem[2].stats
        t.add_row content(gem[1], gem_stats)
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
