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

def scalene_return_check_triagle(*args)
  return :scalene if (args[0] != args[1]) || (args[1] != args[2]) ||
                     (args[2] != args[0])
end
#:reek:ControlParameter:reek:UtilityFunction:

def isosceles_return_check_triagle(*args)
  return :isosceles if (args[0] == args[1]) || (args[1] == args[2]) ||
                       (args[2] == args[0])
end
#:reek:ControlParameter:reek:UtilityFunction:

def equilateral_return_check_triagle(*args)
  return :equilateral if (args[0] == args[1]) && (args[1] == args[2])
end
#:reek:ControlParameter:
# :reek:FeatureEnvy:

def check_below_zero_triagle(*args)
  raise TriangleError if (args[0] <= 0) || (args[1] <= 0) || (args[2] <= 0)
end
#:reek:ControlParameter:

# rubocop:disable Metrics/AbcSize
# :reek:FeatureEnvy:
def triangle(*args)
  check_below_zero_triagle(*args)

  result = equilateral_return_check_triagle(*args) ||
           isosceles_return_check_triagle(*args) ||
           scalene_return_check_triagle(*args)

  raise TriangleError if (args[0] + args[1] < args[2]) ||
                         (args[1] + args[2] < args[0]) ||
                         (args[2] + args[0] <= args[1])

  result
end
# rubocop:enable Metrics/AbcSize

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
