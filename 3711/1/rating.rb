class Rating
  def initialize(gems)
    @gems = gems
  end

  def rate
    @gems.sort { |fgem, sgem| sgem.score <=> fgem.score }
  end
end
