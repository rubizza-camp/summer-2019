require 'table_print'

class Printer
  def self.print_gems(gem_arr)
    tp gem_arr.map(&:gem_data), %i[name used_by watched_by stars forks contributors issues]
  end
end
