require 'terminal-table'

# blabla seokvfkse;dofkosekfo
class TableOutput
  def table_output(array_gems, count_gems_in_argv)
    table = Terminal::Table.new
    table.style = { border_top: false, border_bottom: false }
    how_many_names_need_to_display?(count_gems_in_argv, array_gems.size).to_i.times do |iter|
      table.add_row transformation_into_a_nice_view(array_gems[iter])
    end
    puts table
  end

  private

  def transformation_into_a_nice_view(hash)
    arr_for_table = ['', 'used by ', 'watched by ', 'stars ', 'forks ', 'contributors ', 'issues ']
    iter = -1
    hash.each do |_key, value|
      arr_for_table[iter += 1] += value
    end
    arr_for_table
  end

  def how_many_names_need_to_display?(count_gems_in_argv, count_gems)
    if count_gems_in_argv.to_i > 0 && count_gems_in_argv.to_i < count_gems
      count_gems_in_argv.to_i
    else
      count_gems
    end
  end
end
