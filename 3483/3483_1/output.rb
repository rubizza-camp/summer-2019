class Output
  def self.call(rankings)
    rankings.each_with_index do |gem_, index|
      puts "#{index} place with #{gem_[:points]} have #{gem_[:gem_name]}"
      puts "
            #{gem_[:used_by]} Used by
            #{gem_[:watch]} Watch
            #{gem_[:star]} Star
            #{gem_[:fork]} Fork
            #{gem_[:issues]} Issues
            #{gem_[:contributors]} Contributors
            "
    end
  end
end
