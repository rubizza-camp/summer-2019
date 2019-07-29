require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbols < Neo::Koan
  def test_symbols_are_symbols
    symbol = :ruby
    assert_equal true, symbol.is_a?(Symbol)
  end

  def test_symbols_can_be_compared
    the_first_symbol = :a_symbol
    the_second_symbol = :a_symbol
    the_third_symbol = :something_else

    assert_equal true, the_first_symbol == the_second_symbol
    assert_equal false, the_first_symbol == the_third_symbol
  end

  def test_identical_symbols_are_a_single_internal_object
    the_first_symbol = :a_symbol
    the_second_symbol = :a_symbol

    assert_equal true, the_first_symbol == the_second_symbol
    assert_equal true, the_first_symbol.object_id == the_second_symbol.object_id
  end

  # rubocop:disable Style/SymbolProc
  def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |word| word.to_s }
    assert_equal true, symbols_as_strings.include?('test_method_names_become_symbols')
  end
  # rubocop:enable Style/SymbolProc
  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare
  # against the string value rather than against symbols?

  # rubocop:disable Style/SymbolProc, Style/MutableConstant
  in_ruby_version('mri') do
    RUBY_CONSTANT = 'What is the sound of one hand clapping?'
    def test_constants_become_symbols
      all_symbols_as_strings = Symbol.all_symbols.map { |word| word.to_s }

      assert_equal false, all_symbols_as_strings.include?(RUBY_CONSTANT)
    end
  end
  # rubocop:enable Style/SymbolProc, Style/MutableConstant

  def test_symbols_can_be_made_from_strings
    string = 'catsAndDogs'
    assert_equal :catsAndDogs, string.to_sym
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :'cats and dogs'

    assert_equal symbol.to_sym, symbol
  end

  def test_symbols_with_interpolation_can_be_built
    value = 'and'
    symbol = :"cats #{value} dogs"

    assert_equal symbol.to_sym, symbol
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal 'It is raining cats and dogs.', string
  end

  def test_symbols_are_not_strings
    symbol = :ruby
    assert_equal false, symbol.is_a?(String)
    assert_equal false, symbol.eql?('ruby')
  end

  # :reek:ManualDispatch:
  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal false, symbol.respond_to?(:each_char)
    assert_equal false, symbol.respond_to?(:reverse)
  end

  # It's important to realize that symbols are not 'immutable
  # strings', though they are immutable. None of the
  # interesting string operations are available on symbols.

  def test_symbols_cannot_be_concatenated
    # Exceptions will be pondered further down the path
    assert_raise(NoMethodError) do
      :cats + :dogs
    end
  end

  def test_symbols_can_be_dynamically_created
    assert_equal :catsdogs, ('cats' + 'dogs').to_sym
  end

  # THINK ABOUT IT:
  #
  # Why is it not a good idea to dynamically create a lot of symbols?
end
