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

def length(a, b, c)
  return true if a + b > c
end

def side_less_than_zero(a, b, c)
  return true if (a <= 0) || (b <= 0) || (c <= 0)
end

def check_sides(a, b, c)
  return false if side_less_than_zero(a, b, c)
  return true if length(a, b, c) && length(b, c, a) && length(c, a, b)
end

def triangle(a, b, c)
  array_of_sides = [a, b, c]
  raise TriangleError, 'Wrong parameters' unless check_sides(a, b, c)

  case array_of_sides.uniq.size
  when 2
    return :isosceles
  when 1
    return :equilateral
  end
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
