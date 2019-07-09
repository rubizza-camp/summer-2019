# frozen_string_literal: true

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
#:reek:FeatureEnvy
# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
def triangle(side_a, side_b, side_c)
  raise TriangleError if (side_a <= 0) || (side_b <= 0) || (side_c <= 0)
  raise TriangleError if (side_a + side_b <= side_c) || (side_b + side_c <= side_a) || (side_a + side_c <= side_b)
  return :equilateral if (side_a == side_b) && (side_a == side_c) && (side_b == side_c)
  return :isosceles if (side_a == side_b) || (side_b == side_c) || (side_a == side_c)

  :scalene
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
#:reek:FeatureEnvy
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
