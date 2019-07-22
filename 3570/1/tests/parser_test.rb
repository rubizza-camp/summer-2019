require 'minitest/autorun'
require_relative '../parser'

class TestParser < Minitest::Test
  def test_return_gems_stats
    first_gem = Parser.new(['rails']).parse.first
    assert_equal first_gem[0], 'rails'
    assert first_gem[1].is_a?(Integer)
  end
end
