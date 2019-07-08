# Triangle Project Code.

# Triangle analyzes the lengths of the sides of side_a triangle
# (represented by side_a, side_b and side_c) and returns the type of triangle.
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

def length(side_a, side_b, side_c)
  return true if side_a + side_b > side_c
end

def side_less_than_zero(side_a, side_b, side_c)
  return true if (side_a <= 0) || (side_b <= 0) || (side_c <= 0)
end

def check_sides(side_a, side_b, side_c)
  return false if side_less_than_zero(side_a, side_b, side_c)
  return true if length(side_a, side_b, side_c) && length(side_b, side_c, side_a) && length(side_c, side_a, side_b)
end

def triangle(side_a, side_b, side_c)
  array_of_sides = [side_a, side_b, side_c]
  raise TriangleError, 'Wrong parameters' unless check_sides(side_a, side_b, side_c)

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
