require 'table_print'

class Printer
  def self.print_gems(gem_arr)
    tp gem_arr, :name, :used_by, :watched_by, :stars, :forks, :contribs, :issues
  end
end
