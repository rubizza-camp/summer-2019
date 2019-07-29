class GemSerializer
  def self.call(stats)
    [stats[:gem], "used by #{stats[:used_by]}",
     "watched by #{stats[:watch]}", "#{stats[:star]} stars",
     "#{stats[:fork]} forks", "#{stats[:contributors]} contributors",
     "#{stats[:issues]} issues"]
  end
end
