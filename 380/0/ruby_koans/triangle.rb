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
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/LineLength
# :reek:TooManyStatements, :reek:FeatureEnvy

def triangle(a_s, b_s, c_s)
  raise TriangleError, 'one or many sides equal to zero!' if a_s.equal?(0) || c_s.equal?(0) || b_s.equal?(0)
  raise TriangleError, 'one or more sides less than zero' if a_s.negative? || b_s.negative? || c_s.negative?
  raise TriangleError, 'No two sides can add to be less than or equal to the other side' if (a_s + b_s <= c_s) || (a_s + c_s <= b_s) || (b_s + c_s <= a_s)
  return :equilateral if a_s.equal?(b_s) && a_s.equal?(c_s)
  return :isosceles if a_s.equal?(b_s) || a_s.equal?(c_s) || b_s.equal?(c_s)

  :scalene
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/LineLength

# Errsor class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
