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
def triangle(a, b, c)
  raise TriangleError, "Sides must be greater than zero" if (a <= 0) || (b <= 0) || (c <= 0)
  raise TriangleError, "No two sides can be less than other side" if (a+b <= c) || (a+c <= b) || (b+c <= a)
  return :equilateral if (a == b && b == c)
  return :isosceles if ( a == b || b == c || a == c )
  return :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
