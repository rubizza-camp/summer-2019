require File.expand_path(File.dirname(__FILE__) + '/neo')

<<<<<<< HEAD
class AboutMessagePassing < Neo::Koan
  class MessageCatcher
    def caught?
      true
    end
  end

  def test_methods_can_be_called_directly
    mc = MessageCatcher.new

    assert mc.caught?
  end

  def test_methods_can_be_invoked_by_sending_the_message
    mc = MessageCatcher.new

    assert mc.send(:caught?)
  end

  def test_methods_can_be_invoked_more_dynamically
    mc = MessageCatcher.new

    assert mc.send('caught?')
    assert mc.send('caught' + '?') # What do you need to add to the first string?
    assert mc.send('CAUGHT?'.downcase) # What would you need to do to the string?
  end

  def test_send_with_underscores_will_also_send_messages
    mc = MessageCatcher.new

    assert_equal true, mc.__send__(:caught?)

    # THINK ABOUT IT:
    #
    # Why does Ruby provide both send and __send__ ?
  end
  # :reek:ManualDispatch

  def test_classes_can_be_asked_if_they_know_how_to_respond
    mc = MessageCatcher.new

    assert_equal true, mc.respond_to?(:caught?)
    assert_equal false, mc.respond_to?(:does_not_exist)
  end

  # ------------------------------------------------------------------

  class MessageCatcher
    def add_a_payload(*args)
      args
    end
  end

  def test_sending_a_message_with_arguments
    mc = MessageCatcher.new

    assert_equal [], mc.add_a_payload
    assert_equal [], mc.send(:add_a_payload)

    assert_equal [3, 4, nil, 6], mc.add_a_payload(3, 4, nil, 6)
    assert_equal [3, 4, nil, 6], mc.send(:add_a_payload, 3, 4, nil, 6)
  end

  # NOTE:
  #
  # Both obj.msg and obj.send(:msg) sends the message named :msg to
  # the object. We use "send" when the name of the message can vary
  # dynamically (e.g. calculated at run time), but by far the most
  # common way of sending a message is just to say: obj.msg.

  # ------------------------------------------------------------------

  class TypicalObject
  end

  def test_sending_undefined_messages_to_a_typical_object_results_in_errors
    typical = TypicalObject.new

    exception = assert_raise(NoMethodError) do
      typical.foobar
    end
    assert_match(/foobar/, exception.message)
  end

  def test_calling_method_missing_causes_the_no_method_error
    typical = TypicalObject.new

    exception = assert_raise(NoMethodError) do
      typical.method_missing(:foobar)
    end
    assert_match(/foobar/, exception.message)

    # THINK ABOUT IT:
    #
    # If the method :method_missing causes the NoMethodError, then
    # what would happen if we redefine method_missing?
    #
    # NOTE:
    #
    # In Ruby 1.8 the method_missing method is public and can be
    # called as shown above. However, in Ruby 1.9 (and later versions)
    # the method_missing method is private. We explicitly made it
    # public in the testing framework so this example works in both
    # versions of Ruby. Just keep in mind you can't call
    # method_missing like that after Ruby 1.9 normally.
    #
    # Thanks.  We now return you to your regularly scheduled Ruby
    # Koans.
  end

  # ------------------------------------------------------------------
  # rubocop:disable Style/MethodMissing
  class AllMessageCatcher
    # :reek:UtilityFunction
    def method_missing(method_name, *args)
      "Someone called #{method_name} with <#{args.join(', ')}>"
    end
  end

  def test_all_messages_are_caught
    catcher = AllMessageCatcher.new

    assert_equal 'Someone called foobar with <>', catcher.foobar
    assert_equal 'Someone called foobaz with <1>', catcher.foobaz(1)
    assert_equal 'Someone called sum with <1, 2, 3, 4, 5, 6>', catcher.sum(1, 2, 3, 4, 5, 6)
  end
  # :reek:ManualDispatch

  def test_catching_messages_makes_respond_to_lie
    catcher = AllMessageCatcher.new

    assert_nothing_raised do
      catcher.any_method
    end
    assert_equal false, catcher.respond_to?(:any_method)
  end

  # ------------------------------------------------------------------

  class WellBehavedFooCatcher
    def method_missing(method_name, *args, &block)
      if method_name.to_s[0, 3] == 'foo'
        'Foo to you too'
      else
        super(method_name, *args, &block)
      end
    end
  end
  # rubocop:enable Style/MethodMissing
  def test_foo_method_are_caught
    catcher = WellBehavedFooCatcher.new

    assert_equal 'Foo to you too', catcher.foo_bar
    assert_equal 'Foo to you too', catcher.foo_baz
  end

  def test_non_foo_messages_are_treated_normally
    catcher = WellBehavedFooCatcher.new

    assert_raise(NoMethodError) do
      catcher.normal_undefined_method
    end
  end

  # ------------------------------------------------------------------

  # (note: just reopening class from above)
  class WellBehavedFooCatcher
    def respond_to?(method_name)
      if method_name.to_s[0, 3] == 'foo'
        true
      else
        super(method_name)
      end
    end
  end
  # :reek:ManualDispatch

  def test_explicitly_implementing_respond_to_lets_objects_tell_the_truth
    catcher = WellBehavedFooCatcher.new

    assert_equal true, catcher.respond_to?(:foo_bar)
    assert_equal false, catcher.respond_to?(:something_else)
  end
=======
class AboutIteration < Neo::Koan
  # -- An Aside ------------------------------------------------------
  # Ruby 1.8 stores names as strings. Ruby 1.9 and later stores names
  # as symbols. So we use a version dependent method "as_name" to
  # convert to the right format in the koans. We will use "as_name"
  # whenever comparing to lists of methods.

  in_ruby_version('1.8') do
    # :reek:UtilityFunction
    def as_name(name)
      name.to_s
    end
  end

  in_ruby_version('1.9', '2') do
    # :reek:UtilityFunction
    def as_name(name)
      name.to_sym
    end
  end

  # Ok, now back to the Koans.
  # -------------------------------------------------------------------

  def test_each_is_a_method_on_arrays
    assert_equal true, [].methods.include?(as_name(:each))
  end

  def test_iterating_with_each
    array = [1, 2, 3]
    sum = 0
    array.each do |item|
      sum += item
    end
    assert_equal 6, sum
  end

  def test_each_can_use_curly_brace_blocks_too
    array = [1, 2, 3]
    sum = 0
    array.each { |item| sum += item }
    assert_equal 6, sum
  end
  # :reek:TooManyStatements

  def test_break_works_with_each_style_iterations
    array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    sum = 0
    array.each do |item|
      break if item > 3

      sum += item
    end
    assert_equal 6, sum
  end
  # :reek:TooManyStatements

  def test_collect_transforms_elements_of_an_array
    array = [1, 2, 3]
    new_array = array.collect { |item| item + 10 }
    assert_equal [11, 12, 13], new_array

    # NOTE: 'map' is another name for the 'collect' operation
    another_array = array.map { |item| item + 10 }
    assert_equal [11, 12, 13], another_array
  end
  # :reek:TooManyStatements

  def test_select_selects_certain_items_from_an_array
    array = [1, 2, 3, 4, 5, 6]

    even_numbers = array.select { |item| (item % 2).zero? }
    assert_equal [2, 4, 6], even_numbers

    # NOTE: 'find_all' is another name for the 'select' operation
    more_even_numbers = array.find_all { |item| (item % 2).zero? }
    assert_equal [2, 4, 6], more_even_numbers
  end

  def test_find_locates_the_first_element_matching_a_criteria
    array = %w[Jim Bill Clarence Doug Eli]

    assert_equal 'Clarence', (array.find { |item| item.size > 4 })
  end
  # :reek:TooManyStatements

  def test_inject_will_blow_your_mind
    result = [2, 3, 4].inject(0) { |sum, item| sum + item }
    assert_equal 9, result

    result_two = [2, 3, 4].inject(1) { |product, item| product * item }
    assert_equal 24, result_two

    # Extra Credit:
    # Describe in your own words what inject does.
  end
  # :reek:TooManyStatements
  # :reek:NestedIterators

  def test_all_iteration_methods_work_on_any_collection_not_just_arrays
    # Ranges act like a collection
    result = (1..3).map { |item| item + 10 }
    assert_equal [11, 12, 13], result

    # Files act like a collection of lines
    File.open('example_file.txt') do |file|
      upcase_lines = file.map { |line| line.strip.upcase }
      assert_equal %w[THIS IS A TEST], upcase_lines
    end

    # NOTE: You can create your own collections that work with each,
    # map, select, etc.
  end

  # Bonus Question:  In the previous koan, we saw the construct:
  #
  #   File.open(filename) do |file|
  #     # code to read 'file'
  #   end
  #
  # Why did we do it that way instead of the following?
  #
  #   file = File.open(filename)
  #   # code to read 'file'
  #
  # When you get to the "AboutSandwichCode" koan, recheck your answer.
>>>>>>> master
end
