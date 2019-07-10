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
def triangle(side_a, side_b, side_c)
  if check_statement(side_a, side_b, side_c)
    type_of_triangle = process_legs(side_a, side_b, side_c)
    return :scalene, type_of_triangle
  end
  raise TriangleError
end

def process_legs(side_a, side_b, side_c)
  raise_error_on_statement(side_a, side_b, side_c)
  return :equilateral if side_c == side_a && side_c == side_b
  return :isosceles if side_c == side_a || side_c == side_b || side_a == side_b
end

def raise_error_on_statement(side_a, side_b, side_c)
  raise TriangleError if side_a <= 0 || side_b <= 0 || side_c <= 0
end

def check_statement(side_a, side_b, side_c)
  ((side_a + side_b) > side_c) &&
    ((side_a + side_c) > side_b) && ((side_b + side_c) > side_a)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
