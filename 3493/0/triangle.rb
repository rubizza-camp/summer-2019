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
# :reek:ControlParameter:
# :reek:FeatureEnvy:
# rubocop:disable Style/SymbolProc, Metrics/AbcSize:

def triangle_validation?(*args)
  (args[0] + args[1] <= args[2]) || (args[1] + args[2] <= args[0]) ||
    (args[2] + args[0] <= args[1]) || args.any? { |argument| argument.negative? }
end
#:reek:ControlParameter:
# :reek:FeatureEnvy:
# rubocop:enable Style/SymbolProc, Metrics/AbcSize:

def triangle(*args)
  raise TriangleError if triangle_validation?(*args)
  case args.uniq.count
  when 3
    :scalene
  when 2
    :isosceles
  when 1
    :equilateral
  end
end
# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
