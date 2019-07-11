# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/MethodLength
# Triangle Project Code.
# :reek:all
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
def triangle(s_a, s_b, s_c)
  raise TriangleError if s_a.zero? || s_b.zero? || s_c.zero?
  raise TriangleError if s_a.negative? || s_b.negative? || s_c.negative?
  raise TriangleError if ((s_a + s_b) < s_c) || ((s_a + s_c) < s_b) || ((s_b + s_c) < s_a)
  raise TriangleError if ((s_a + s_b) == s_c) || ((s_a + s_c) == s_b) || ((s_b + s_c) == s_a)

  if (s_a == s_b) && (s_b == s_c) && (s_a == s_c)
    :equilateral
  elsif (s_a == s_b) || (s_a == s_c) || (s_b == s_c)
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/MethodLength
