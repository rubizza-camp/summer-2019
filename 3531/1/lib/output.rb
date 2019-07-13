# rubocop:disable  Lint/MissingCopEnableDirective, Metrics/LineLength, Metrics/AbcSize

class Output
  def initialize(params)
    @name = params[:name] if params[:name]
    # array starts with 0
    @top = params[:top] - 1 if params[:top]
  end

  def gems(gems)
    ready_gems = gems
    ready_gems = gems[0..@top] if @top
    ready_gems = ready_gems.select { |gem| gem.dig(1).include?(@name) } if @name

    output_gems(ready_gems)
  end

  def output_gems(ready_gems)
    table = Terminal::Table.new do |t|
      ready_gems.each do |gem|
        t.add_row [gem[2].name.to_s, "used by #{gem[2].stats[:used_by]}", "watched by #{gem[2].stats[:watched_by]}", "#{gem[2].stats[:stars]} stars", "#{gem[2].stats[:forks]} forks", "#{gem[2].stats[:contributors]} contributors", "#{gem[2].stats[:issues]} issues"]
      end
    end

    system('clear')
    puts table
  end
end
