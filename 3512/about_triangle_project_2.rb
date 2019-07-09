require File.expand_path(File.dirname(__FILE__) + '/neo')

# You need to write the triangle method in the file 'triangle.rb'
require './triangle.rb'

class AboutTriangleProject2 < Neo::Koan
  # The first assignment did not talk about how to handle errors.
  # Let's handle that part now.
  def test_illegal_triangles_throw_exceptions
    assert_raise(TriangleError) { triangle(0, 0, 0) }
    assert_raise(TriangleError) { triangle(3, 4, -5) }
    assert_raise(TriangleError) { triangle(1, 1, 3) }
    assert_raise(TriangleError) { triangle(2, 4, 2) }
    # HINT: for tips, see http://stackoverflow.com/questions/3834203/ruby-koan-151-raising-exceptions
  end
end
def triangle(var_a, var_b, var_c)
  side = [var_a, var_b, var_c].sort

  raise TriangleError, 'No negative' if side.any? { |s| s <= 0 }
  raise TriangleError, 'Triangle fails' unless (side[0] + side[1]) > side[2]

  uniqueside = side.uniq.length
  types = [nil, :equilateral, :isosceles, :scalene]
  types[uniqueside]
end
