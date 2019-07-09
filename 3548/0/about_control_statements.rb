require File.expand_path(File.dirname(__FILE__) + '/neo')
# :reek:TooManyMethods
# This class smells of :reek:RepeatedConditional
# About control statements
class AboutControlStatements < Neo::Koan # rubocop:disable Metrics/ClassLength
  # :reek:RepeatedConditional
  def test_if_then_else_statements
    if true  # rubocop:disable Lint/LiteralAsCondition, Style/ConditionalAssignment
      result = :true_value
    else
      result = :false_value
    end
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
    if true  # rubocop:disable Lint/LiteralAsCondition, Style/IfUnlessModifier
      result = :true_value
    end
    assert_equal :true_value, result
  end

  def test_if_statements_return_values
    value = if true # rubocop:disable Lint/LiteralAsCondition
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value
    if_statements_return_values
    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end

  # :reek:RepeatedConditional
  def if_statements_return_values
    value = if false # rubocop:disable Lint/LiteralAsCondition
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value
  end

  def test_if_statements_with_no_else_with_false_condition_return_value
    value = if false # rubocop:disable Lint/LiteralAsCondition, Style/IfUnlessModifier
              :true_value
            end
    assert_equal nil, value
  end

  def test_condition_operators
    # rubocop:disable Lint/LiteralAsCondition
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
    # rubocop:enable Lint/LiteralAsCondition
  end

  def test_if_statement_modifiers
    # rubocop:disable Lint/LiteralAsCondition
    result = :default_value
    result = :true_value if true

    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    unless false    # rubocop:disable Style/IfUnlessModifier, Layout/ExtraSpacing
      result = :false_value
    end
    assert_equal :false_value, result
    # rubocop:enable Lint/LiteralAsCondition
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    unless true # rubocop:disable Lint/LiteralAsCondition, Style/IfUnlessModifier
      result = :true_value
    end
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false # rubocop:disable Lint/LiteralAsCondition

    assert_equal :false_value, result
  end

  # :reek:FeatureEnvy
  def test_while_statement
    integer = 1
    result = 1
    while integer <= 10
      result *= integer
      integer += 1
    end
    assert_equal 3_628_800, result
  end

  # :reek:TooManyStatements
  def test_break_statement
    integer = 1
    result = 1
    loop do
      break unless integer <= 10
      result *= integer
      integer += 1
    end
    assert_equal 3_628_800, result
  end

  # :reek:FeatureEnvy
  def test_break_statement_returns_values
    integer = 1
    result = while integer <= 10
               break integer if (integer % 2).zero?
               integer += 1
             end

    assert_equal 2, result
  end

  # :reek:TooManyStatements
  def test_next_statement
    integer = 0
    result = []
    while_integer(integer, result)
    assert_equal [1, 3, 5, 7, 9], result
  end

  # :reek:UtilityFunction
  def while_integer(integer, result)
    while integer < 10
      integer += 1
      next if (integer % 2).zero?
      result << integer
    end
  end

  def test_for_statement
    array = %w[fish and chips]
    result = []
    for item in array # rubocop:disable Style/For
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
