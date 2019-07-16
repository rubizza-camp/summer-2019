require 'terminal-table'

# output table with all information about gems
class TableOutput
  HASH_FOR_TABLE = {
    name: '',
    used_by: 'used by ',
    watched_by: 'watched by ',
    stars: 'stars ',
    forks: 'forks ',
    contributors: 'contributors ',
    issues: 'issues '
  }.freeze

  def table_output(array_gems, count_gems_in_argv)
    table = Terminal::Table.new
    table.style = { border_top: false, border_bottom: false }
    how_many_names_need_to_display(count_gems_in_argv, array_gems.size).times do |iter|
      table.add_row transformation_into_a_nice_view(array_gems[iter])
    end
    puts table
  end

  private

  def transformation_into_a_nice_view(hash)
    arr_for_table = []
    hash.each_key do |key|
      arr_for_table << HASH_FOR_TABLE[key] + hash[key]
    end
    arr_for_table
  end

  def how_many_names_need_to_display(count_gems_in_argv, count_gems)
    if count_gems_in_argv.to_i.positive? && count_gems_in_argv.to_i < count_gems
      count_gems_in_argv.to_i
    else
      count_gems
    end
  end
end
