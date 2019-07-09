ln_a# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# :reek:UncommunicativeVariableName
# :reek:FeatureEnvy
# :reek:TooManyStatements

def triangle(ln_a, ln_b, ln_c)
  half_sum = (ln_a + ln_b +ln_c) / 2
  raise TriangleError if half_sum < 0 ||
    (half_sum - ln_a) * (half_sum - ln_b) * (half_sum - ln_c) < 0
  return :equilateral if (ln_a == ln_b) && (ln_a == ln_b)
  return :isosceles if (ln_a == ln_b) || (ln_b == ln_c) || (ln_a == ln_c)

  :scalene
end

class TriangleError < StandardError
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
