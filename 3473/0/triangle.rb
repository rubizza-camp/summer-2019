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
def triangle(a_side, b_side, c_side)
  a_side, b_side, c_side = [a_side, b_side, c_side].sort
  raise TriangleError unless triangle?(a_side, b_side, c_side)

  triangle_type a_side, b_side, c_side
end

def triangle?(a_side, b_side, c_side)
  a_side.positive? && (a_side + b_side > c_side)
end

def triangle_type(a_side, b_side, c_side)
  # if exactly 2 sides are equal, check if all
  if (a_side == b_side) || (b_side == c_side) || (a_side == c_side)
    return (a_side == b_side) && (b_side == c_side) ? :equilateral : :isosceles
  end

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
