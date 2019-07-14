# rubocop:disable Metrics/AbcSize
#:reek:FeatureEnvy and :reek:UtilityFunction
class Algoritm
  def get_points(mass)
    (0...mass.size).each do |elem|
      mass[elem] << " #{mass[elem][1].split(' ').last.to_i *
                        mass[elem][2].split(' ').last.to_i *
                        mass[elem][3].split(' ').last.to_i} Yan Points"
    end
  end

  def vivod(mass)
    (0...mass[0].size).each do |elem|
      puts "#{elem} place #{mass[0][elem][0]}\n #{mass[0][elem]}"
    end
  end

  def get_top(mass)
    watt = []
    get_points(mass)
    watt << mass.sort_by { |elem| elem[9].split(' ').first.to_i }.reverse
    vivod(watt)
  end
end
# rubocop:enable Metrics/AbcSize
