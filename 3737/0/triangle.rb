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
def triangle(ast, bst, cst)
  ast, bst, cst = [ast, bst, cst].sort
  raise TriangleError unless ast.positive?
  raise TriangleError if bst + ast <= cst

  kind(ast, bst, cst)
  # WRITE THIS CODE
end

def kind(ast, bst, cst)
  return :equilateral if ast == bst && ast == cst

  return :isosceles if ast == bst || ast == cst || bst == cst

  :scalene
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end
