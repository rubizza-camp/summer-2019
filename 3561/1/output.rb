class Output
  def print_gems(hash_of_gems)
    hash_of_gems.each do |gem|
      gem.to_str
      puts "\n"
    end
  end
end
