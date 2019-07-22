# frozen_string_literal: true

# rubocop: disable Style/EvalWithLocation

require File.expand_path(File.dirname(__FILE__) + '/neo')
# :reek:UncommunicativeVariableName
# :reek:UncommunicativeParameterName
# :reek:TooManyMethods
# :reek:UtilityFunction
def sum_method(side1, side2)
  side1 + side2
end

# :reek:UncommunicativeParameterName
# :reek:TooManyStatements
# :reek:TooManyMethods
# :reek:UtilityFunction
class AboutMethods < Neo::Koan
  def test_calling_global_methods
    assert_equal 5, sum_method(2, 3)
  end

  def test_calling_global_methods_without_parentheses
    result = sum_method 2, 3
    assert_equal 5, result
  end

  # (NOTE: We are Using eval below because the example code is
  # considered to be syntactically invalid).
  def test_sometimes_missing_parentheses_are_ambiguous
    eval 'assert_equal 5, sum_method(2, 3)'
  end

  # NOTE: wrong number of arguments is not a SYNTAX error, but a
  # runtime error.
  def test_calling_global_methods_with_wrong_number_of_arguments
    exception = assert_raise(ArgumentError) do
      sum_method
    end
    assert_match(/["wrong number of arguments (0 for 2)"]/, exception.message)

    exception = assert_raise(ArgumentError) do
      sum_method(1, 2, 3)
    end
    assert_match(/["wrong number of arguments (3 for 2)"]/, exception.message)
  end

  # ------------------------------------------------------------------

  def method_with_defaults(side1, side2 = :default_value)
    [side1, side2]
  end

  def test_calling_with_default_values
    assert_equal [1, :default_value], method_with_defaults(1)
    assert_equal [1, 2], method_with_defaults(1, 2)
  end

  # ------------------------------------------------------------------

  def method_with_var_args(*args)
    args
  end

  def test_calling_with_variable_arguments
    assert_equal Array, method_with_var_args.class
    assert_equal [], method_with_var_args
    assert_equal [:one], method_with_var_args(:one)
    assert_equal %i[one two], method_with_var_args(:one, :two)
  end

  # ------------------------------------------------------------------

  def method_with_explicit_return
    :return_value
  end

  def test_method_with_explicit_return
    assert_equal :return_value, method_with_explicit_return
  end

  # ------------------------------------------------------------------

  def method_without_explicit_return
    :return_value
  end

  def test_method_without_explicit_return
    assert_equal :return_value, method_without_explicit_return
  end

  # ------------------------------------------------------------------

  def multiplication_method(side1, side2)
    side1 * side2
  end

  def test_calling_methods_in_same_class
    assert_equal 12, multiplication_method(3, 4)
  end

  def test_calling_methods_in_same_class_with_explicit_receiver
    assert_equal 12, multiplication_method(3, 4)
  end

  # ------------------------------------------------------------------

  def test_calling_private_methods_without_receiver
    assert_equal 'a secret', my_private_method
  end

  def private_method_regexp
    /private method/
  end

  def self.test_calling_private_methods_with_an_explicit_receiver
    exception = assert_raise(NoMethodError) do
      my_private_method
    end
    assert_match private_method_regexp, exception.message
  end

  private

  def my_private_method
    'a secret'
  end

  # ------------------------------------------------------------------

  class Dog
    def name
      'Fido'
    end

    private

    def tail
      'tail'
    end
  end

  def test_calling_methods_in_other_objects_require_explicit_receiver
    rover = Dog.new
    assert_equal 'Fido', rover.name
  end

  def test_calling_private_methods_in_other_objects
    rover = Dog.new
    assert_raise(NoMethodError) do
      rover.tail
    end
  end
end

# rubocop: enable Style/EvalWithLocation
