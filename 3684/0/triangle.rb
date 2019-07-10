# Triangle Project Code.

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/LineLength
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

# :reek:FeatureEnvy
def triangle(first, second, third)
  triangle_sides = [first, second, third].sort
  raise TriangleError if first <= 0 || second <= 0 || third <= 0 || (triangle_sides[0] + triangle_sides[1] <= triangle_sides[2])

  if first == second && second == third
    :equilateral
  elsif first == second || second == third || first == third
    :isosceles
  else
    :scalene
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/LineLength
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
