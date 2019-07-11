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
# :reek:FeatureEnvy
def triangle(s_a, s_b, s_c)
  triangle_does_not_exists(s_a, s_b, s_c)

  return :equilateral if (s_a == s_b) && (s_b == s_c)
  return :isosceles if (s_a == s_b) || (s_b == s_c) || (s_c == s_a)

  :scalene
end

def triangle_does_not_exists(s_a, s_b, s_c)
  s_a_b = s_a + s_b
  s_b_c = s_b + s_c
  s_c_a = s_c + s_a
  if (s_a_b <= s_c) ||
     (s_b_c <= s_a) ||
     (s_c_a <= s_b)
    raise TriangleError
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
