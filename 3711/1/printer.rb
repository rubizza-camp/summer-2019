class Printer
  # rubocop:disable Metrics/MethodLength
  def self.print_it(gem_arr)
    gem_arr.each do |gem|
      puts [
        gem.name,
        "used by #{gem.used_by}",
        "watched by #{gem.watched_by}",
        "#{gem.stars} stars",
        "#{gem.forks} forks",
        "#{gem.contributors} contributors",
        "#{gem.issues} issues"
      ].join("\t| ")
    end
  end
  # rubocop:enable Metrics/MethodLength
end
