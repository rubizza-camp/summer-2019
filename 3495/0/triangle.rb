# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/GuardClause

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
class Triangle
  attr_reader :side_a, :side_b, :side_c

  def initialize(side_a, side_b, side_c)
    @side_a = side_a
    @side_b = side_b
    @side_c = side_c
  end

  def type
    if a_triangle?(self) || a_triangle_2?(self) || a_triangle_3?(self)
      raise TriangleError, 'the triangle does not exist'
    elsif a_equilateral?(self)
      :equilateral
    elsif a_isosceles?(self)
      :isosceles
    elsif a_scalene?(self)
      :scalene
    end
  end

  def a_triangle?(triangle)
    true if (triangle.side_a + triangle.side_b <= triangle.side_c) ||
            (triangle.side_a + triangle.side_c <= triangle.side_b)
  end

  def a_triangle_2?(triangle)
    true if triangle.side_a <= 0 || triangle.side_b <= 0 || triangle.side_c <= 0
  end

  def a_triangle_3?(triangle)
    true if triangle.side_c + triangle.side_b <= triangle.side_a
  end

  def a_equilateral?(triangle)
    true if (triangle.side_a == triangle.side_b) && (triangle.side_b ==
            triangle.side_c) && (triangle.side_a == triangle.side_c)
  end

  def a_isosceles?(triangle)
    true if (triangle.side_a == triangle.side_b) || (triangle.side_b ==
            triangle.side_c) || (triangle.side_a == triangle.side_c)
  end

  def a_scalene?(triangle)
    true if (triangle.side_a != triangle.side_b) && (triangle.side_b !=
            triangle.side_c) && (triangle.side_a != triangle.side_c)
  end
end
# :reek:UtilityFunction

def triangle(side_a, side_b, side_c)
  Triangle.new(side_a, side_b, side_c).type
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/GuardClause
