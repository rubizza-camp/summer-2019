# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# :reek:UncommunicativeVariableName
# :reek:FeatureEnvy
# :reek:TooManyStatements

def triangle(ln_a, ln_b, ln_c)
  ln_a, ln_b, c = [ln_a, ln_b, ln_c].sort
  raise TriangleError unless ln_a > 0
  raise TriangleError unless ln_a + ln_b > ln_c
  return :equilateral if ln_a == ln_c
  return :isosceles if ln_a == ln_b or bln_b == ln_c
  :scalene
end

class TriangleError < StandardError
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
