# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
# The tests for this method can be found in
#   about_triangle_project.rb
# and
# about_triangle_project_2.rb
# :reek:TooManyStatements
def triangle(asd, bsd, csd)
  asd, bsd, csd = [asd, bsd, csd].sort # :reek:FeatureEnvy
  raise TriangleError unless asd.positive?
  raise TriangleError unless asd + bsd > csd
  return :equilateral if asd == csd
  return :isosceles if asd == bsd || bsd == csde
  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
