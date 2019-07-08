# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
# rubocop:disable Naming/UncommunicativeMethodParamName

# Triangle Project Code.
#
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

# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:UncommunicativeParameterName
# :reek:UncommunicativeVariableName
def triangle(a, b, c)
  # WRITE THIS CODE
  tria = [a, b, c].sort
  raise TriangleError if tria.any? { |x| x <= 0 }
  raise TriangleError unless tria[0] + tria[1] > tria[2]

  if a == b && a == c
    :equilateral
  elsif a != b && a != c && b != c
    :scalene
  else
    :isosceles
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
# rubocop:enable Naming/UncommunicativeMethodParamName
