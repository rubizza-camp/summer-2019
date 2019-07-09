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

def a_triangle?(side_a, side_b, side_c)
  true if (side_a + side_b <= side_c) ||
          (side_a + side_c <= side_b) || (side_c + side_b <= side_a)
end

def a_triangle_2?(side_a, side_b, side_c)
  true if side_a <= 0 || side_b <= 0 || side_c <= 0
end

def a_equilateral?(side_a, side_b, side_c)
  true if side_a == side_b && side_b == side_c && side_a == side_c
end

def a_isosceles?(side_a, side_b, side_c)
  true if side_a == side_b || side_b == side_c || side_a == side_c
end

def a_scalene?(side_a, side_b, side_c)
  true if side_a != side_b && side_b != side_c && side_a != side_c
end

def triangle(side_a, side_b, side_c)
  if a_triangle?(side_a, side_b, side_c) ||
     a_triangle_2?(side_a, side_b, side_c)
    raise TriangleError, 'the triangle does not exist'
  elsif a_equilateral?(side_a, side_b, side_c)
    :equilateral
  elsif a_isosceles?(side_a, side_b, side_c)
    :isosceles
  elsif a_scalene?(side_a, side_b, side_c)
    :scalene
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
