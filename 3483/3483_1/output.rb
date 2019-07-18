# rubocop:disable Metrics/AbcSize
#:reek:FeatureEnvy
class Output
  def output(array_with_hash)
    (0...array_with_hash.size).each do |elem| # places go from 0 not a bug but a ficha
      puts "#{elem} place whith #{array_with_hash[elem]['Points:']}
            have #{array_with_hash[elem]['Gem Name:']}"
      puts "
            #{array_with_hash[elem]['Used_by:']} Used by
            #{array_with_hash[elem]['Watch:']} Watch
            #{array_with_hash[elem]['Star:']} Star
            #{array_with_hash[elem]['Fork:']} Fork
            #{array_with_hash[elem]['Issues:']} Issues
            #{array_with_hash[elem]['Contributors:']} Contributors
            "
    end
  end
end
# rubocop:enable Metrics/AbcSize
