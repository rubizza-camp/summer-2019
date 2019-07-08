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
def triangle_kind(side_a, side_b, side_c)
  return :equilateral if (side_a == side_b) && (side_b == side_c)
  return :isosceles if (side_a == side_b) || (side_b == side_c) || (side_c == side_a)

  :scalene
end

def triangle(side_a, side_b, side_c)
  variable_one = side_a + side_b
  variable_two = side_b + side_c
  variable_tree = side_c + side_a
  if variable_one <= side_c || variable_two <= side_a || variable_tree <= side_b
    raise TriangleError, 'Bad side length: triangle does not exist'
  end

  triangle_kind(side_a, side_b, side_c)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
