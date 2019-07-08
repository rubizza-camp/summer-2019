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
def check_error(p_a, p_b, p_c)
  raise TriangleError if (p_a + p_b <= p_c) || (p_b + p_c <= p_a) || (p_c + p_a <= p_b)
end

def triangle(p_a, p_b, p_c)
  check_error(p_a, p_b, p_c)
  if (p_a == p_b) && (p_b == p_c)
    :equilateral
  elsif (p_a == p_b) || (p_a == p_c) || (p_b == p_c)
    :isosceles
  else
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
