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
        t.add_row content(gem)
      end
    end
    puts ''
    puts table
  end

  def content(gem)
    [
      name(gem), "used by #{used_by(gem)}",
      "watched by #{watched_by(gem)}", "#{stars(gem)} stars",
      "#{forks(gem)} forks", "#{contributors(gem)} contributors",
      "#{issues(gem)} issues"
    ]
  end

  def name(gem)
    gem[2].name.to_s
  end

  def used_by(gem)
    gem[2].stats[:used_by]
  end

  def watched_by(gem)
    gem[2].stats[:watched_by]
  end

  def stars(gem)
    gem[2].stats[:stars]
  end

  def forks(gem)
    gem[2].stats[:forks]
  end

  def contributors(gem)
    gem[2].stats[:contributors]
  end

  def issues(gem)
    gem[2].stats[:issues]
  end
end
