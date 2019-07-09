# !/usr/bin/env ruby
# -*- ruby -*-

require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutAsserts < Neo::Koan
  def test_assert_truth
    assert true
  end

  def test_assert_with_message
    assert true, 'This should be true -- Please fix this'
  end

  def test_assert_equality
    expected_value = 2
    actual_value = 1 + 1

    assert expected_value == actual_value
  end

  def test_a_better_way_of_asserting_equality
    expected_value = 2
    actual_value = 1 + 1

    assert_equal expected_value, actual_value
  end

  def test_fill_in_values
    assert_equal 2, 1 + 1
  end
end
