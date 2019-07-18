require 'minitest/autorun'

class TestParser < Minitest::Test
  def test_app_returns_result
    output = `ruby top_gems.rb`
    assert_includes output, 'sinatra'
  end
end
