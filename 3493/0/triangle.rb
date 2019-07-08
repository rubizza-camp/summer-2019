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
#:reek:ControlParameter:reek:UtilityFunction:

def scalene_return_check_triagle(first_value, second_value, third_value)
  return :scalene if (first_value != second_value) || (second_value != third_value) ||
                     (third_value != first_value)
end
#:reek:ControlParameter:reek:UtilityFunction:

def isosceles_return_check_triagle(first_value, second_value, third_value)
  return :isosceles if (first_value == second_value) || (second_value == third_value) ||
                       (third_value == first_value)
end
#:reek:ControlParameter:reek:UtilityFunction:

def equilateral_return_check_triagle(first_value, second_value, third_value)
  return :equilateral if (first_value == second_value) && (second_value == third_value)
end
#:reek:ControlParameter:

def check_below_zero_triagle(first_value, second_value, third_value)
  raise TriangleError if (first_value <= 0) || (second_value <= 0) || (third_value <= 0)
end
#:reek:ControlParameter:

def triangle(first_value, second_value, third_value)
  check_below_zero_triagle(first_value, second_value, third_value)

  result = equilateral_return_check_triagle(first_value, second_value, third_value) ||
           isosceles_return_check_triagle(first_value, second_value, third_value) ||
           scalene_return_check_triagle(first_value, second_value, third_value)

  raise TriangleError if (first_value + second_value < third_value) ||
                         (second_value + third_value < first_value) ||
                         (third_value + first_value <= second_value)

  result
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
