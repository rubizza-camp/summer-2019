class PrintTable
  def self.print_table(gem_hash)
    rows = []
    gem_hash.each do |_key, value|
      rows << [value[:name], "used by #{value[:count_used_by]}",
               "watched by #{value[:count_watched]}", "#{value[:count_stars]} stars",
               "#{value[:count_forks]} forks", "#{value[:count_contributors]} contibutors",
               "#{value[:count_issues]} issues"]
    end
    table = Terminal::Table.new rows: rows
    puts table
  end
end
