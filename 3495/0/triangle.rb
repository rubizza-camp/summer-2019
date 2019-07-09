# triangle Project Code.

# triangle analyzes the lengths of the sides of a triangle
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
# :reek:UtilityFunction
# rubocop:disable Metrics/AbcSize, Style/GuardClause
class Triangle
  attr_reader :side_a, :side_b, :side_c

  def initialize(side_a, side_b, side_c)
    @side_a = side_a
    @side_b = side_b
    @side_c = side_c
  end

  def type
    if check_triangle_existence
      raise TriangleError, 'the triangle does not exist'
    elsif a_equilateral?
      :equilateral
    elsif a_isosceles?
      :isosceles
    elsif a_scalene?
      :scalene
    end
  end

  def check_triangle_existence
    ((side_a + side_b <= side_c) || (side_a + side_c <= side_b) ||
      side_a <= 0 || side_b <= 0 || side_c <= 0 ||
      side_c + side_b <= side_a)
  end

  def a_equilateral?
    (side_a == side_b) && (side_b == side_c) && (side_a == side_c)
  end

  def a_isosceles?
    (side_a == side_b) || (side_b == side_c) || (side_a == side_c)
  end

  def a_scalene?
    (side_a != side_b) && (side_b != side_c) && (side_a != side_c)
  end
end
# :reek:UtilityFunction

def triangle(side_a, side_b, side_c)
  Triangle.new(side_a, side_b, side_c).type
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Style/GuardClause, Metrics/AbcSize
