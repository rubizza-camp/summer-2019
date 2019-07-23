class ConsoleOutput
  HEADERS = [
    'Gem',
    'Used by',
    'Watched by',
    'Stars',
    'Forks',
    'Contributors',
    'Issues'
  ].freeze

  def console_output(final_stat)
    table = Terminal::Table.new headings: HEADERS, rows: final_stat
    puts table
  end
end
