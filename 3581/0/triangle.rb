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
def triangle(leg_a, leg_b, leg_c)
  if check_statement(leg_a, leg_b, leg_c)
    type_of_triangle = process_legs(leg_a, leg_b, leg_c)
    return type_of_triangle.nil? ? :scalene : type_of_triangle
  end
  raise TriangleError
end

def process_legs(leg_a, leg_b, leg_c)
  raise_error_on_statement(leg_a, leg_b, leg_c)
  return :equilateral if leg_c == leg_a && leg_c == leg_b
  return :isosceles if leg_c == leg_a || leg_c == leg_b || leg_a == leg_b
end

def raise_error_on_statement(leg_a, leg_b, leg_c)
  raise TriangleError if leg_a <= 0 || leg_b <= 0 || leg_c <= 0
end

def check_statement(leg_a, leg_b, leg_c)
  ((leg_a + leg_b) > leg_c) &&
    ((leg_a + leg_c) > leg_b) && ((leg_b + leg_c) > leg_a)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
