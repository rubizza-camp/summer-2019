# rubocop:disable Metrics/AbcSize
class TheBestGem
  def get_top(array)
    output_array = []
    take_yan_points(array)
    output_array << array.sort_by { |elem| elem[7].split(' ').first.to_i }.reverse
    output(output_array)
  end

  private

  def take_yan_points(array)
    (0...array.size).each do |elem|
      array[elem] << " #{array[elem][1].to_i *
                        array[elem][2].to_i *
                        array[elem][3].to_i}  Yan Points"
    end
  end

  #:reek:FeatureEnvy
  def output(array)
    (0...array[0].size).each do |elem| # places go from 0 not a bug but a ficha
      puts "#{elem} place whith #{array[0][elem].pop} have #{array[0][elem].pop}"
      puts "
            #{array[0][elem][0]} Used by
            #{array[0][elem][1]} Watch
            #{array[0][elem][2]} Star
            #{array[0][elem][3]} Fork
            #{array[0][elem][4]} Issues
            #{array[0][elem][5]} Contributors
            "
    end
  end
end
# rubocop:enable Metrics/AbcSize
