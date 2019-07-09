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

def triangle_analyzes(*args)
  case args.uniq.count
  when 3
    :scalene
  when 2
    :isosceles
  when 1
    :equilateral
  end
end
# :reek:ControlParameter:
# :reek:FeatureEnvy:
# rubocop:disable Style/SymbolProc

def check_below_zero_triagle(*args)
  raise TriangleError if args.each { |argument| argument.negative? }
end
# rubocop:disable Metrics/AbcSize:
# :reek:FeatureEnvy:

def check_no_triangle(*args)
  raise TriangleError if (args[0] + args[1] < args[2]) || (args[1] + args[2] < args[0]) ||
                         (args[2] + args[0] <= args[1])
end
#:reek:ControlParameter:
# :reek:FeatureEnvy:
# rubocop:enable Style/SymbolProc, Metrics/AbcSize:

def triangle(*args)
  check_below_zero_triagle(*args)
  check_no_triangle(*args)
  triangle_analyzes(*args)
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
