# rubocop:disable Lint/LiteralAsCondition, Metrics/ClassLength, Style/ConditionalAssignment
# rubocop:disable Style/IfUnlessModifier, Style/InfiniteLoop, Style/For

require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:RepeatedConditional
class AboutControlStatements < Neo::Koan
  def test_if_then_else_statements
    if true
      result = :true_value
    else
      result = :false_value
    end
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
    if true
      result = :true_value
    end
    assert_equal :true_value, result
  end

  # rubocop:disable Metrics/MethodLength
  # :reek:TooManyStatements
  def test_if_statements_return_values
    value = if true
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value

    value = if false
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value

    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end

  # rubocop:enable Metrics/MethodLength

  def test_if_statements_with_no_else_with_false_condition_return_value
    value = if false
              :true_value
            end
    assert_equal nil, value
  end

  def test_condition_operators
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
  end

  def test_if_statement_modifiers
    result = :default_value
    result = :true_value if true

    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
    unless false # same as saying 'if !false', which evaluates as 'if true'
      result = :false_value
    end
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
    result = :true_value unless true # same as saying 'if !true', which evaluates as 'if false'
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
    result = :false_value unless false

    assert_equal :false_value, result
  end

  # :reek:FeatureEnvy
  def test_while_statement
    i_param = 1
    result = 1
    while i_param <= 10
      result *= i_param
      i_param += 1
    end
    assert_equal 3_628_800, result
  end

  # :reek:TooManyStatements, :reek:FeatureEnvy, :reek:UncommunicativeVariableName
  def test_break_statement
    i = 1
    result = 1
    while true
      break unless i <= 10
      result *= i
      i += 1
    end
    assert_equal 3_628_800, result
  end

  # :reek:FeatureEnvy, :reek:UncommunicativeVariableName
  def test_break_statement_returns_values
    i = 1
    result = while i <= 10
               break i if i.even?
               i += 1
             end

    assert_equal 2, result
  end

  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def test_next_statement
    i_param = 0
    result = []
    while i_param < 10
      i_param += 1
      next if i_param.even?

      result << i_param
    end
    assert_equal [1, 3, 5, 7, 9], result
  end

  def test_for_statement
    array = %w[fish and chips]
    result = []
    for item in array
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
# rubocop:enable Lint/LiteralAsCondition, Metrics/ClassLength, Style/ConditionalAssignment
# rubocop:enable Style/IfUnlessModifier, Style/InfiniteLoop, Style/For
