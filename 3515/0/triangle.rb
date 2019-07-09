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
# :reek:UncommunicativeMethodName

def triangle1(first, second, third)
  raise TriangleError if (first <= 0) || (second <= 0) || (third <= 0)
end

# :reek:UncommunicativeMethodName
# :reek:FeatureEnvyame

def triangle2(first, second, third)
  raise TriangleError if (first + second <= third) ||
                         (first + third <= second) || (second + third <= first)
end

# :reek:ControlParameter
# :reek:UncommunicativeMethodName
# :reek:UtilityFunction

def triangle3(first, second, third)
  return :equilateral if (first == second) && (second == third)
end

# :reek:ControlParameter
# :reek:UncommunicativeMethodName
# :reek:UtilityFunction

def triangle4(first, second, third)
  return :isosceles if (first == second) || (first == third) || (second == third)
end

# :reek:ControlParameter
# :reek:UncommunicativeMethodName
# :reek:UtilityFunction

def triangle5(first, second, third)
  :scalene if first != second && second != third && third != first
end

# rubocop:disable Lint/UselessAssignment

def triangle(first, second, third)
  # WRITE THIS CODE
  result = triangle1(first, second, third) ||
           triangle2(first, second, third) ||
           triangle3(first, second, third) ||
           triangle4(first, second, third) ||
           triangle5(first, second, third)
end

# rubocop:enable Lint/UselessAssignment

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
