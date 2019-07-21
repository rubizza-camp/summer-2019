class TerminalTable
  def initialize(gem_row, len)
    final_arr = gem_row.sort! { |el_1st, el_2nd| el_1st.last <=> el_2nd.last }.reverse!
    puts Terminal::Table.new headings: %w[gem_name watched_by stars forks
                                          issues contributors used_by gem_rate],
                             rows: final_arr[0..(len - 1)]
  end
end
