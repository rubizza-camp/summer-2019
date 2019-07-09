# rubocop:disable all
require File.expand_path(File.dirname(__FILE__) + '/neo')

# :reek:NilCheck
# :reek:UncommunicativeVariableName

class AboutNil < Neo::Koan
  def test_nil_is_an_object
    assert_equal true, nil.is_a?(Object), 'Unlike NULL in other languages'
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    # What happens when you call a method that doesn't exist.  The
    # following begin/rescue/end code block captures the exception and
    # makes some assertions about it.

    nil.some_method_nil_doesnt_know_about
  rescue Exception => e
    # What exception has been caught?
    assert_equal NoMethodError, e.class

    # What message was attached to the exception?
    # (HINT: replace __ with part of the error message.)
    assert_match(/undefined method .* for nil:NilClass/, e.message)
  end

  def test_nil_has_a_few_methods_defined_on_it
    assert_equal true, nil.nil?
    assert_equal '', nil.to_s
    assert_equal 'nil', nil.inspect

    # THINK ABOUT IT:
    #
    # Is it better to use
    #    obj.nil?
    # or
    #    obj == nil
    # Why?
    # I think nil? is better, 'couse == is a micro comparison
    # with the other object to determine if it is the same object.
    # All the objects will return false to the .nil? message
    # except for the object nil itself
  end
end
# rubocop:enable all