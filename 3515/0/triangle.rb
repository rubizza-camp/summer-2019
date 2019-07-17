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
# :reek:UtilityFunction

def triangle_are_the_sides_positive?(first, second, third)
  raise TriangleError if (first <= 0) || (second <= 0) || (third <= 0)
end

# :reek:FeatureEnvyame

def triangle_exist?(first, second, third)
  raise TriangleError if (first + second <= third) ||
                         (first + third <= second) || (second + third <= first)
end

# :reek:ControlParameter
# :reek:UtilityFunction

def triangle_equilateral(first, second, third)
  return :equilateral if (first == second) && (second == third)
end

# :reek:ControlParameter
# :reek:UtilityFunction

def triangle_isosceles(first, second, third)
  return :isosceles if (first == second) || (first == third) || (second == third)
end

# :reek:ControlParameter
# :reek:UtilityFunction

def triangle_scalene(first, second, third)
  :scalene if first != second && second != third && third != first
end

def triangle(first, second, third)
  triangle_are_the_sides_positive?(first, second, third) ||
    triangle_exist?(first, second, third) ||
    triangle_equilateral(first, second, third) ||
    triangle_isosceles(first, second, third) ||
    triangle_scalene(first, second, third)
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
