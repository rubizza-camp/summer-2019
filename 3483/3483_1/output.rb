class Output
  def self.call(rankings)
    rankings.each_with_index do |elem, index|
      puts "#{index} place whith #{elem[:points]} have #{elem[:gem_name]}"
      puts "
            #{elem[:used_by]} Used by
            #{elem[:watch]} Watch
            #{elem[:star]} Star
            #{elem[:fork]} Fork
            #{elem[:issues]} Issues
            #{elem[:contributors]} Contributors
            "
    end
  end
end
