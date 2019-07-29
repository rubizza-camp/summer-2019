require 'terminal-table'

class Table
  def show(gems)
    Terminal::Table.new do |table|
      gem_list_to_show(gems, table)
    end
  end

  private

  def gem_list_to_show(gems, table)
    gems.each do |name, stat|
      table << [
        name, "used by #{stat[:used_by]}", "watch #{stat[:watch]}",
        "forks #{stat[:forks]}", "stars #{stat[:star]}",
        "issues #{stat[:issues]}", "contributors #{stat[:contributors]}"
      ]
    end
  end
end
