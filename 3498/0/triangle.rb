# rubocop:disable Style/GuardClause
# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

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
def triangle(t_a, t_b, t_c)
  raise TriangleError if t_a + t_b <= t_c || t_a + t_c <= t_b || t_b + t_c <= t_a

  if t_a == t_b && t_b == t_c
    return :equilateral
  elsif t_a == t_b || t_a == t_c || t_b == t_c
    return :isosceles
  else
    return :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Style/GuardClause
# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
