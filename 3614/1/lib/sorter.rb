class Sorter
  def initialize(gems_stat)
    @params = ARGV.empty? ? [] : ARGV.first.split('=')
    @gems_stat = gems_stat
  end

  def sort
    @gems_stat.sort_by! { |gem_stat| gem_stat[1] - gem_stat[6] * 1000 }.reverse!
    sort_by_key
    @gems_stat
  end

  def sort_by_key
    key, value = @params

    case key
    when '--top'
      @gems_stat = @gems_stat[0...value.to_i]
    when '--name'
      @gems_stat = @gems_stat.map do |gem_stat|
        gem_stat[0].include?(value) ? gem_stat : nil
      end.compact
    end
  end
end
