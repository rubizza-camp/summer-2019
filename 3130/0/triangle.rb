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
# :reek:disable
def check_sides_sums(first, second, third)
  first + second > third && first + third > second && second + third > first
end
# :reek:enable

# :reek:disable
def validate_sides(first, second, third)
  first.positive? && second.positive? && third.positive?
end
# :reek:enable

# :reek:disable
def isosceles?(first, second, third)
  first == second || first == third || second == third
end
# :reek:enable

# :reek:disable
def triangle(first, second, third)
  raise TriangleError if !validate_sides(first, second, third) ||
                         !check_sides_sums(first, second, third)

  return :equilateral if first == second && second == third
  return :isosceles if isosceles?(first, second, third)

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# :reek:enable
