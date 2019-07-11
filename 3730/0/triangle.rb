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
#
# rubocop:disable Metrics/CyclomaticComplexity, Naming/UncommunicativeMethodParamName
# rubocop:disable Metrics/PerceivedComplexity, Style/GuardClause
# :reek:FeatureEnvy
# :reek:UncommunicativeParameterName
# :reek:UncommunicativeVariableName

def triangle(a, b, c)
  # WRITE THIS CODE
  a, b, c = [a, b, c].sort
  raise TriangleError if a <= 0 || a + b <= c

  return :equilateral if a == b && b == c
  if a == b || b == c || a == c
    return :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/CyclomaticComplexity, Naming/UncommunicativeMethodParamName
# rubocop:enable Metrics/PerceivedComplexity, Style/GuardClause
