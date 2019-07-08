require File.expand_path(File.dirname(__FILE__) + '/neo')
# rubocop:disable all
class AboutControlStatements < Neo::Koan
  def test_if_then_else_statements
    if true
# rubocop:enable all
      result = :true_value
    else
      result = :false_value
    end
    assert_equal :true_value, result
  end

  def test_if_then_statements
    result = :default_value
# rubocop:disable all
    if true
# rubocop:enable all
      result = :true_value
    end
    assert_equal :true_value, result
  end
# rubocop:disable all
  def test_if_statements_return_values
    value = if true
# rubocop:enable all
              :true_value
            else
              :false_value
            end
    assert_equal :true_value, value
# rubocop:disable all
    value = if false
# rubocop:enable all
              :true_value
            else
              :false_value
            end
    assert_equal :false_value, value
    # NOTE: Actually, EVERY statement in Ruby will return a value, not
    # just if statements.
  end

  def test_if_statements_with_no_else_with_false_condition_return_value
# rubocop:disable all
    value = if false
# rubocop:enable all
              :true_value
            end
    assert_equal nil, value
  end

  def test_condition_operators
# rubocop:disable all
    assert_equal :true_value, (true ? :true_value : :false_value)
    assert_equal :false_value, (false ? :true_value : :false_value)
# rubocop:enable all
  end

  def test_if_statement_modifiers
    result = :default_value
# rubocop:disable all
    result = :true_value if true
# rubocop:enable all
    assert_equal :true_value, result
  end

  def test_unless_statement
    result = :default_value
# rubocop:disable all
    unless false # same as saying 'if !false', which evaluates as 'if true'
# rubocop:enable all
      result = :false_value
    end
    assert_equal :false_value, result
  end

  def test_unless_statement_evaluate_true
    result = :default_value
# rubocop:disable all
    unless true # same as saying 'if !true', which evaluates as 'if false'
# rubocop:enable all
      result = :true_value
    end
    assert_equal :default_value, result
  end

  def test_unless_statement_modifier
    result = :default_value
# rubocop:disable all
    result = :false_value unless false
# rubocop:enable all
    assert_equal :false_value, result
  end

  def test_while_statement
    i = 1
    result = 1
    while i <= 10
      result *= result
      i += 1
    end
# rubocop:disable all
    assert_equal 3628800, result
# rubocop:enable all
  end

  def test_break_statement
    i = 1
    result = 1
# rubocop:disable all
    while true
# rubocop:enable all
      break unless i <= 10
      result *= result
      i += 1
    end
# rubocop:disable all
    assert_equal 3628800, result
# rubocop:enable all
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
    array.each do
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
