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
# :reek:FeatureEnvy
# :reek:UncommunicativeParameterName
def triangle(site1, site2, site3)
  invalid_traingle?(site1, site2, site3)
  if site1 == site2 && site2 == site3
    :equilateral
  elsif site1 == site2 || site1 == site3 || site2 == site3
    :isosceles
  else
    :scalene
  end
end

# :reek:UncommunicativeParameterName
# :reek:FeatureEnvy
def invalid_traingle?(site1, site2, site3)
  sum = (site1 + site2 + site3) / 2.0
  sides = (sum - site1) * (sum - site2) * (sum - site3)
  raise TriangleError if site1 <= 0 || site2 <= 0 || site3 <= 0 || sides <= 0
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
