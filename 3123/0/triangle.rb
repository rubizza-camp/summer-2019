# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
# :reek:ClassVariable
# :reek:TooManyStatements
# :reek:UncommunicativeMethodName
# :reek:UncommunicativeParameterName
# :reek:UncommunicativeVariableName
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize

# :reek:FeatureEnvy
def triangle(a_a, b_b, c_c)
  raise TriangleError if (a_a <= 0) || (b_b <= 0) || (c_c <= 0)
  raise TriangleError if ((a_a + b_b) < c_c) || ((b_b + c_c) < a_a) || ((a_a + c_c) < b_b)
  raise TriangleError if ((a_a + b_b) == c_c) || ((a_a + c_c) == b_b) || ((b_b + c_c) == a_a)
  return :equilateral if a_a == c_c && a_a == b_b && c_c == b_b
  return :isosceles if a_a == b_b || a_a == c_c || b_b == c_c
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
# rubocop:enable Metrics/AbcSize
