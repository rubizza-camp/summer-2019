require File.expand_path(File.dirname(__FILE__) + '/neo')

<<<<<<< HEAD
=======
# rubocop:disable Lint/UnneededCopDisableDirective
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
class AboutNil < Neo::Koan
  def test_nil_is_an_object
    assert_equal true, nil.is_a?(Object), 'Unlike NULL in other languages'
  end

  def test_you_dont_get_null_pointer_errors_when_calling_methods_on_nil
    # What happens when you call a method that doesn't exist.  The
    # following begin/rescue/end code block captures the exception and
    # makes some assertions about it.

    nil.some_method_nil_doesnt_know_about
<<<<<<< HEAD
  rescue StandardError => e
    # What exception has been caught?
    assert_equal NoMethodError, e.class

    # What message was attached to the exception?
    # (HINT: replace __ with part of the error message.)
    assert_match(/undefined method/, e.message)
  end

=======
  rescue StandardError => err
    # What exception has been caught?
    assert_equal NoMethodError, err.class

    # What message was attached to the exception?
    # (HINT: replace __ with part of the error message.)
    assert_match(/undefined method/, err.message)
  end

  # rubocop:disable NilCheck
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
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
  end
<<<<<<< HEAD
end
=======
  # rubocop:enable NilCheck
end
# rubocop:enable Lint/UnneededCopDisableDirective
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
