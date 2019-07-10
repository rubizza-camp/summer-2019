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
# rubocop:disabel Metrics/LineLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# :reek:TooManyStatements

def triangle(a_s, b_s, c_s)
  raise TriangleError if a_s.equal?(0) && c_s.equal?(0) && b_s.equal?(0)
  raise TriangleError if a_s < 0 || b_s < 0 || c_s < 0
  raise TriangleError if (a_s + b_s <= c_s) || (a_s + c_s <= b_s) || (b_s + c_s <= a_s)

  return :equilateral if a_side.equal?(b_side) && a_side.equal?(c_side)
  return :isosceles if a_side.equal?(b_side) || a_side.equal?(c_side) || b_side.equal?(c_side)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/AbcSize
