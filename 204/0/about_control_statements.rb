# frozen_string_literal: true

# rubocop: disable  Metrics/MethodLength, Metrics/ClassLength, Lint/UnneededCopDisableDirective

require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
# :reek:RepeatedConditional

class AboutControlStatements < Neo::Koan
  def test_if_then_else_statements
    true_condition = true
    result = if true_condition
               :true_value
             else
               :false_value
             end
    assert_equal :true_value, result
  end

  def test_if_then_statements
    true_condition = true
    result = :default_value
    result = :true_value if true_condition
    assert_equal :true_value, result
  end
  # rubocop:disable Lint/ShadowedArgument

  def value_true
    true_condition = true
    value =
      if true_condition
        :true_value
      else
        :false_value
      end
    assert_equal :true_value, value

    false_condition = false
    value =
      if false_condition
        :true_value
      else
        :false_value
      end
    assert_equal :false_value, value
  end
  # rubocop:enable Lint/ShadowedArgument

  def test_if_statements_with_no_else_with_false_condition_return_value
    false_condition = false
    value = :true_value if false_condition
    assert_equal nil, value
  end

  def test_condition_operators
    false_condition = false
    true_condition = true
    assert_equal :true_value, (true_condition ? :true_value : :false_value)
    assert_equal :false_value, (false_condition ? :true_value : :false_value)
  end

  def test_if_statement_modifiers
    true_condition = true
    result = :default_value
    result = :true_value if true_condition
    assert_equal :true_value, result
  end

  def test_unless_statement
    false_condition = false
    result = :default_value
    result = :false_value unless false_condition
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    true_condition = true
    result = :default_value
    result = :true_value unless true_condition
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    false_condition = false
    result = :default_value
    result = :false_value unless false_condition

    assert_equal :false_value, result
  end

  def test_while_statement
    i = 1
    result = 1
    while i <= 10
      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement
    i = 1
    result = 1
    loop do
      break unless i <= 10

      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
               break i if i.even?

               i += 1
             end
    assert_equal 2, result
  end

  def test_next_statement
    i = 0
    result = []
    while i < 10
      i += 1
      next if i.even?

      result << i
    end
    assert_equal [1, 3, 5, 7, 9], result
  end

  def test_for_statement
    array = %w[fish and chips]
    result = []
    array.each do |item|
      result << item.upcase
    end
    assert_equal %w[FISH AND CHIPS], result
  end

  def test_times_statement
    sum = 0
    10.times do
      sum += 1
    end
    assert_equal 10, sum
  end
end

# rubocop: enable  Metrics/MethodLength, Metrics/ClassLength, Lint/UnneededCopDisableDirective
