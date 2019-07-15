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

# :reek:TooManyStatements and :reek:FeatureEnvy
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/CyclomaticComplexity
def triangle(a_s, b_s, c_s)
  # Check triangle sides length
  a_s, b_s, c_s = sides = [a_s, b_s, c_s].sort { |side_a, side_b| -1 * (side_a <=> side_b) }
  if sides.any? { |side| side <= 0 }
    raise TriangleError, 'All sides have to be more than 0'
  end
  if a_s >= b_s + c_s
    raise TriangleError, "One side of triangle can't be equal or longer then the other two"
  end

  # Return triangle type
  return :equilateral if a_s == b_s && b_s == c_s
  return :isosceles if a_s == b_s || a_s == c_s || b_s == c_s
  :scalene
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
