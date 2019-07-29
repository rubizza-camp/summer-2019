class PrintTable
  def self.call(gem_hash)
    rows = []
    gem_hash.each do |_, value|
      rows << [value[:name], "used by #{value[:count_used_by]}",
               "watched by #{value[:count_watched]}", "#{value[:count_stars]} stars",
               "#{value[:count_forks]} forks", "#{value[:count_contributors]} contibutors",
               "#{value[:count_issues]} issues"]
    end
    puts Terminal::Table.new rows: rows
  end
end
