require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutTrueAndFalse < Neo::Koan
<<<<<<< HEAD
=======
  # rubocop:disable Lint/UnneededCopDisableDirective
  # rubocop:disable ControlParameter
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d
  def truth_value(condition)
    if condition
      :true_stuff
    else
      :false_stuff
    end
  end
<<<<<<< HEAD
=======
  # rubocop:enable ControlParameter
  # rubocop:enable Lint/UnneededCopDisableDirective
>>>>>>> ecc5273a98f21b47f778c5467994ffd510a3139d

  def test_true_is_treated_as_true
    assert_equal :true_stuff, truth_value(true)
  end

  def test_false_is_treated_as_false
    assert_equal :false_stuff, truth_value(false)
  end

  def test_nil_is_treated_as_false_too
    assert_equal :false_stuff, truth_value(nil)
  end

  def test_everything_else_is_treated_as_true
    assert_equal :true_stuff, truth_value(1)
    assert_equal :true_stuff, truth_value(0)
    assert_equal :true_stuff, truth_value([])
    assert_equal :true_stuff, truth_value({})
    assert_equal :true_stuff, truth_value('Strings')
    assert_equal :true_stuff, truth_value('')
  end
end
