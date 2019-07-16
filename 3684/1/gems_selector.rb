require 'pry'
class GemsSelector
  def initialize(array_of_gems, flags)
    @gems = array_of_gems
    @flags = flags
  end

  def select_gems
    make_top
    change_info
    @gems
  end

  private

  def make_top
    @gems.each { |item| item.store(:coefficient, calculate_coefficient(item)) }
    @gems = @gems.sort_by { |item| -item[:coefficient] }.each { |item| item.delete(:coefficient) }
  end

  def change_info
    @gems = @gems.take(@flags[:number].to_i) if @flags[:number]
    check_for_a_word if @flags[:word]
  end

  def calculate_coefficient(item)
    used_by = item[:used_by].delete(',').to_i
    stars = item[:stars].delete(',').to_i
    used_by_coefficient = 0.01
    stars_coefficient = 0.3
    (used_by * used_by_coefficient + stars * stars_coefficient).round
  end

  def check_for_a_word
    @gems.select! do |element|
      element[:gem_name].include?(@flags[:word])
    end
  end
end
