# :reek:UncommunicativeVariableName
# :reek:FeatureEnvy
# :reek:TooManyStatements
# rubocop:disable Lint/UselessAssignment
def triangle(ln_a, ln_b, ln_c)
  ln_a, ln_b, c = [ln_a, ln_b, ln_c].sort
  raise TriangleError unless ln_a > 0
  raise TriangleError unless ln_a + ln_b > ln_c
  return :equilateral if ln_a == ln_c
  return :isosceles if ln_a == ln_b || bln_b == ln_c
  :scalene
end

class TriangleError < StandardError
end

# rubocop:enable Lint/UselessAssignment
