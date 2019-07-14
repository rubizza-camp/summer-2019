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
# :reek:TooManyStatements
# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
# :reek:Metrics/AbcSize
# :reek:Metrics/CyclomaticComplexity
def triangle(a_var, b_var, c_var)
  sides = [a_var, b_var, c_var].sort
  long = sides[2]
  short1 = sides[1]
  short2 = sides[0]
  raise TriangleError, 'Side of the triangle can not be <=0' if sides.min <= 0
  raise TriangleError, 'Longest side should exceed the sum of short ones' if short1 + short2 <= long
  type_checker(long, short1, short2)
end

def type_checker(long, short1, short2)
  return :equilateral if long == short1 && short1 == short2
  return :isosceles if long == short1 || short1 == short2
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
