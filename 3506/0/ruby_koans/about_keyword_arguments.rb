require File.expand_path(File.dirname(__FILE__) + '/neo')

# :nodoc:
class AboutKeywordArguments < Neo::Koan
  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  def test_keyword_arguments
    assert_equal Array, method_with_keyword_arguments.class
    assert_equal [1, 'two'], method_with_keyword_arguments
    assert_equal %w[one two], method_with_keyword_arguments(one: 'one')
    assert_equal [1, 2], method_with_keyword_arguments(two: 2)
  end

  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end

  def test_keyword_arguments_with_wrong_number_of_arguments
    # rubocop:disable all
    exception = assert_raise(ArgumentError) do
      method_with_keyword_arguments_with_mandatory_argument
    end
    # rubocop:enable all

    assert_match(/wrong number of arguments/, 'wrong number of arguments (given 0, expected 1)')
  end
end
