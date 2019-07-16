class GemsSelector
  USED_BY_COEFFICIENT = 0.01
  STARS_COEFFICIENT = 0.3
  def initialize(gems, flags)
    @gems = gems
    @flags = flags
  end

  def select_gems
    filter_by_subname
    sort_gems
    top_n_gems
    @gems
  end

  private

  def sort_gems
    @gems.each { |item| item[:coefficient] = calculate_coefficient(item) }
    @gems = @gems.sort_by { |item| -item[:coefficient] }.each { |item| item.delete(:coefficient) }
  end

  def top_n_gems
    @gems = @gems.take(@flags[:number].to_i) if @flags[:number]
  end

  def calculate_coefficient(item)
    used_by = item[:used_by].delete(',').to_i
    stars = item[:stars].delete(',').to_i
    (used_by * USED_BY_COEFFICIENT + stars * STARS_COEFFICIENT).round
  end

  def filter_by_subname
    @gems.select! { |element| element[:gem_name].include?(@flags[:word]) } if @flags[:word]
  end
end
